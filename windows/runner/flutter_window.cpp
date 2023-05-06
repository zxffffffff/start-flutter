#include "flutter_window.h"

#include <optional>

#include "flutter/generated_plugin_registrant.h"

#include <flutter/event_channel.h>
#include <flutter/event_sink.h>
#include <flutter/event_stream_handler_functions.h>
#include <flutter/method_channel.h>
#include <flutter/standard_method_codec.h>
#include <windows.h>
#include <memory>

static int GetBatteryLevel()
{
    SYSTEM_POWER_STATUS status;
    if (GetSystemPowerStatus(&status) == 0 || status.BatteryLifePercent == 255)
    {
        return -1;
    }
    return status.BatteryLifePercent;
}

FlutterWindow::FlutterWindow(const flutter::DartProject& project)
    : project_(project) {}

FlutterWindow::~FlutterWindow() {}

bool FlutterWindow::OnCreate() {
    if (!Win32Window::OnCreate()) {
        return false;
    }

    RECT frame = GetClientArea();

    // The size here must match the window dimensions to avoid unnecessary surface
    // creation / destruction in the startup path.
    flutter_controller_ = std::make_unique<flutter::FlutterViewController>(
        frame.right - frame.left, frame.bottom - frame.top, project_);
    // Ensure that basic setup of the controller was successful.
    if (!flutter_controller_->engine() || !flutter_controller_->view())
    {
        return false;
    }
    RegisterPlugins(flutter_controller_->engine());

    // [1] domain前缀 + channel名称
    flutter::MethodChannel<> testChannel(flutter_controller_->engine()->messenger(), "test", &flutter::StandardMethodCodec::GetInstance());
    flutter::MethodChannel<> batteryChannel(flutter_controller_->engine()->messenger(), "samples.flutter.dev/battery", &flutter::StandardMethodCodec::GetInstance());
    // [2] channel方法
    testChannel.SetMethodCallHandler([](const flutter::MethodCall<>& call, std::unique_ptr<flutter::MethodResult<>> result)
        {
            if (call.method_name() == "getSystemClock")
            {
                //std::time_t t = std::chrono::system_clock::to_time_t(std::chrono::system_clock::now());
                std::timespec ts;
                std::timespec_get(&ts, TIME_UTC);
                result->Success(std::vector<int64_t>{ts.tv_sec, ts.tv_nsec});
            }
            else
            {
                result->NotImplemented();
            }
        });
    batteryChannel.SetMethodCallHandler([](const flutter::MethodCall<>& call, std::unique_ptr<flutter::MethodResult<>> result)
        {
            if (call.method_name() == "getBatteryLevel")
            {
                int battery_level = GetBatteryLevel();
                if (battery_level != -1)
                {
                    result->Success(battery_level);
                }
                else
                {
                    result->Error("UNAVAILABLE", "Battery level not available.");
                }
            }
            else
            {
                result->NotImplemented();
            }
        });

    SetChildContent(flutter_controller_->view()->GetNativeWindow());

    flutter_controller_->engine()->SetNextFrameCallback([&]() {
        this->Show();
        });

    return true;
}

void FlutterWindow::OnDestroy() {
    if (flutter_controller_) {
        flutter_controller_ = nullptr;
    }

    Win32Window::OnDestroy();
}

LRESULT
FlutterWindow::MessageHandler(HWND hwnd, UINT const message,
    WPARAM const wparam,
    LPARAM const lparam) noexcept {
    // Give Flutter, including plugins, an opportunity to handle window messages.
    if (flutter_controller_) {
        std::optional<LRESULT> result =
            flutter_controller_->HandleTopLevelWindowProc(hwnd, message, wparam,
                lparam);
        if (result) {
            return *result;
        }
    }

    switch (message) {
    case WM_FONTCHANGE:
        flutter_controller_->engine()->ReloadSystemFonts();
        break;
    }

    return Win32Window::MessageHandler(hwnd, message, wparam, lparam);
}
