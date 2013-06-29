package fi.validi.network.model {
	import flash.events.Event;
	/**
	 * @author jiv
	 */
	public class NetWorldEvent extends Event {
		public static const NODE_CREATED : String = "NODE_CREATED";
		public static const EDGE_CREATED : String = "EDGE_CREATED";
		public static const NETWORK_CREATED : String = "NETWORK_CREATED";
		public static const NETWORK_DESTROYED : String = "NETWORK_DESTROYED";
		public static const NETWORKS_CHANGED : String = "NETWORKS_CHANGED";
		public static const NETWORKS_CASCADE : String = "NETWORKS_CASCADE";
		public static const ACTIVATED : String = "ACTIVATED";
		public static const DEACTIVATED : String = "DEACTIVATED";
		public static const LARGEST_NETWORK_CHANGED : String = "LARGEST_NETWORK_CHANGED";

		private var _netObject : INetObject;

		public function NetWorldEvent(type : String, netObject : INetObject = null, bubble : Boolean = false, cancelable : Boolean = false) {
			_netObject = netObject;
			super(type, bubble, cancelable);
		}

		public function get netObject() : INetObject {
			return _netObject;
		}
		
		override public function toString() : String {
			return super.toString() + ", " + _netObject;
		}
		
	}
}
