package fi.validi.network.view {
	import fi.validi.network.model.INetWorld;
	import flash.display.DisplayObject;
	import fi.validi.network.model.NetWorldEvent;
	import fi.validi.network.model.model2d.NetWorld2D;
	import flash.events.Event;
	import fi.validi.network.model.NetWorld;
	import flash.display.Sprite;

	/**
	 * @author Juho Viitasalo
	 */
	public class AbstractNetWorldView extends Sprite implements INetWorldView {
		protected var _data : INetWorld;
		private var _container : DisplayObject;
		
		
		public function AbstractNetWorldView(data : INetWorld) {
			_data = data;
			_data.addEventListener(Event.CHANGE, draw);
			_data.addEventListener(NetWorldEvent.NODE_CREATED, drawNode);
			_data.addEventListener(NetWorldEvent.EDGE_CREATED, drawEdge);
			_data.addEventListener(NetWorldEvent.NETWORK_CREATED, drawNetworks);
			_data.addEventListener(NetWorldEvent.NETWORK_DESTROYED, eraseNetworks);
			_data.addEventListener(NetWorldEvent.NETWORKS_CHANGED, drawNetworks);
			_data.addEventListener(NetWorldEvent.LARGEST_NETWORK_CHANGED, handleLargestNetworkChange);
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		protected function handleLargestNetworkChange(event : NetWorldEvent) : void {
		}

		private function init(event : Event) : void {
			_container = DisplayObject(parent);
		}

		public function draw(event : Event) : void {
		}

		public function eraseNetworks(event : NetWorldEvent) : void {
		}

		public function drawNetworks(event : NetWorldEvent) : void {
		}

		public function drawEdge(event : NetWorldEvent) : void {
		}

		public function drawNode(event : NetWorldEvent) : void {
		}
		
		public function set data(data : NetWorld2D) : void {
			_data = data;
		}

		public function get container() : DisplayObject {
			return _container;
		}

	}
}
