package fi.validi.network.controller {
	import com.bit101.components.Component_Ronda;
	import fi.validi.network.model.AbstractNetWorld;
	import fi.validi.network.model.INode;
	import fi.validi.network.model.model2d.NetWorld2D;
	import flash.display.Sprite;

	/**
	 * @author jiv
	 */
	public class NetWorldController2D extends AbstractNetWorldController {

		public function NetWorldController2D(data : AbstractNetWorld) {
			super(data);
		}
		
		override public function createRandomNode() : void {
			NetWorld2D(_data).createNode2D(Math.random(), Math.random());
		}
	}
}
