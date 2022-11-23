class BluetootSyncPack {
  double rpm,
      speed,
      fuel,
      oilTemp,
      cvt,
      battery,
      soc,
      latitude,
      longitude,
      timeStamp;

  BluetootSyncPack({
    this.latitude = 0,
    this.longitude = 0,
    this.battery = 0,
    this.soc = 0,
    this.cvt = 0,
    this.fuel = 0,
    this.oilTemp = 0,
    this.rpm = 0,
    this.speed = 0,
    this.timeStamp = 0,
  });
}
