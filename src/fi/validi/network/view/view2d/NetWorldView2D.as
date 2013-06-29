package fi.validi.network.view.view2d {
	import fi.validi.network.model.Network;
	import fi.validi.network.view.INetWorldView;
	import fi.validi.network.view.AbstractNetWorldView;
	import flare.animate.Tween;
	import com.greensock.OverwriteManager;
	import flash.text.TextField;
	import fi.validi.network.model.NetWorldEvent;
	import fi.validi.network.model.model2d.NetWorld2D;
	import fi.validi.network.model.IEdge;
	import fi.validi.network.model.model2d.INode2D;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author Juho Viitasalo
	 */
	public class NetWorldView2D extends AbstractNetWorldView implements INetWorldView {

		private var _nodesLayer : Sprite;
		private var _edgesLayer : Sprite;
		
		private var _numberOfNetworksField : TextField;
		private var _networldContainer : Sprite;

		public function NetWorldView2D(data : NetWorld2D) {
			super(data);
			init();
		}
		
//		override protected function draw(event : Event = null) : void {
//			switch(event.type){
//				case NetWorldEvent.NODE_CREATED:
//					drawNode(event.currentTarget.createdNode);		
//					break;
//				case NetWorldEvent.EDGE_CREATED:
//					drawEdge(event.currentTarget.createdEdge);		
//					break;
//				case NetWorldEvent.NETWORK_CREATED:
//					updateNumberOfNetworks();
//					break;
//				default:
//			}
//		}
		
		private function init():void {
			_nodesLayer = new Sprite();
			_edgesLayer = new Sprite();
			addChild(_nodesLayer);
			addChildAt(_edgesLayer, 0);

			_numberOfNetworksField = new TextField();
			_numberOfNetworksField.text = "0";
			_numberOfNetworksField.scaleX = 2;
			_numberOfNetworksField.scaleY = 2;
			addChild(_numberOfNetworksField);
			
		}

		override public function drawNetworks(event : NetWorldEvent) : void {
			_numberOfNetworksField.text = String(_data.networks.length);
		}
		
		override public function drawNode(event : NetWorldEvent) : void {
			_nodesLayer.addChild(new NodeSprite2D(INode2D(event.netObject),this));
		}

		override public function drawEdge(event : NetWorldEvent) : void {
			_edgesLayer.addChild(new EdgeSprite2D(IEdge(event.netObject),this));
		}
		
		override protected function handleLargestNetworkChange(event : NetWorldEvent) : void {
			Network.deactivateAll();
			Network.largest.activate();
		}

	}
}
