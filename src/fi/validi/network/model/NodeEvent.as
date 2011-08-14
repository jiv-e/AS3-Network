package fi.validi.network.model {
	import flash.events.Event;

	/**
	 * @author jiv
	 */
	public class NodeEvent extends Event {
		public static const REMOVED_FROM_NETWORKS : String = "REMOVED_FROM_NETWORKS";
		private var _netObjects : Vector.<INetObject>;
		
		public function NodeEvent(type : String, netObjects : Vector.<INetObject>, bubbles : Boolean = false, cancelable : Boolean = false) {
			_netObjects = netObjects;
			super(type, bubbles, cancelable);
		}

		public function get netObjects() : Vector.<INetObject> {
			return _netObjects;
		}
	}
}
