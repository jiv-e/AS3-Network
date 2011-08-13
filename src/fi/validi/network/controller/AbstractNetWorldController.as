package fi.validi.network.controller {
	import fi.validi.network.model.AbstractNetWorld;
	import flash.display.Sprite;
	/**
	 * @author jiv
	 */
	public class AbstractNetWorldController extends Sprite {
		
		protected var _data : AbstractNetWorld;
		
		public function AbstractNetWorldController(data : AbstractNetWorld) {
			_data = data;
			init();
		}
		
		private function init() : void {

		}

		
		public function createRandomEdge() : void {
			_data.createRandomInOutEdge();
			//_tempEdge = null;
		}
		
		public function destroyRandomEdge() : void {
//			if (EdgeSprite2D.edgeCount > 0) {
//				EdgeSprite2D(_edgesLayer.getChildAt(Math.floor(Math.random() * _edgesLayer.numChildren))).remove();
//			}
		}
		
		public function destroyAllNodes():void {
//			while (_nodesLayer.numChildren != 0) {
//				NodeSprite2D(_nodesLayer.getChildAt(0)).remove();
//			}
		}
		
		public function addEdges(number : Number) : void {
			for (var i:Number = 0; i < number; i++) {
				createRandomEdge();
			}
		}
		
		public function destroyEdges(number : Number) : void {
			for (var i:Number = 0; i < number; i++) {
				destroyRandomEdge();
			}
		}
		
//		private function createAllEdges(number : Number):void {
//			removeAllEdges();
//			if (validateEdges(number)) {
//				for (var i:Number = 1; i < number; i++)
//				{
//					createRandomEdge();
//				}
//			}
//		}
		
		public function createRandomNode() : void {
			trace("Error : using abstract method!")		  
		}
		
		public function createAllNodes(number : uint) : void {
			//if (_edgesLayer[0] != null) {
				//removeChild(_edgesLayer);
				//_edgesLayer = new Sprite();
			//}
			destroyAllNodes();
			trace("Drawing nodes");
			for (var i:uint = 0; i < number; i++) {

			}
		}
	}
}
