package fi.validi.network.model.model2d {
	import fi.validi.network.model.NetWorldEvent;
	import fi.validi.network.model.AbstractNetWorld;
	import fi.validi.network.model.Edge;
	import fi.validi.network.model.IEdge;
	import fi.validi.network.model.INetwork;
	import fi.validi.network.model.INode;
	import fi.validi.network.model.Network;
	import fi.validi.network.model.NetworkIDCascadeType;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * @author Juho Viitasalo
	 */
	public class NetWorld2D extends AbstractNetWorld {
		
		public function NetWorld2D() {
			super();
		}
		
		public function createNode2D(xProportional : Number, yProportional : Number) : INode {
			initNodeCreation(new Node2D(xProportional, yProportional, createSingleNetworkVector()));			
			return createdNode;
		}
	}
}
