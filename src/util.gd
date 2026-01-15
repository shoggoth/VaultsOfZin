class_name Util

const nc = Callable()

#region Signals
static func sig_disconnect_all(sig: Signal):
	for con in sig.get_connections(): con["signal"].disconnect(con["callable"])
#endregion
