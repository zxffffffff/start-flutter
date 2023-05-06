class Ret<T> {
  const Ret(this.ok, this.err, this.data);
  final bool ok;
  final String err;
  final T data;
}

class Ret2<T1, T2> {
  const Ret2(this.ok, this.err, this.data1, this.data2);
  final bool ok;
  final String err;
  final T1 data1;
  final T2 data2;
}

class Ret3<T1, T2, T3> {
  const Ret3(this.ok, this.err, this.data1, this.data2, this.data3);
  final bool ok;
  final String err;
  final T1 data1;
  final T2 data2;
  final T3 data3;
}

class Ret4<T1, T2, T3, T4> {
  const Ret4(this.ok, this.err, this.data1, this.data2, this.data3, this.data4);
  final bool ok;
  final String err;
  final T1 data1;
  final T2 data2;
  final T3 data3;
  final T3 data4;
}
