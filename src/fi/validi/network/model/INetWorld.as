package fi.validi.network.model {
	import flash.events.IEventDispatcher;
	/**
	 * @author jiv
	 */
	public interface INetWorld extends IEventDispatcher {
		function createEdge(nodesInOut : Vector.<INode>, nodesIn : Vector.<INode> = null, nodesOut : Vector.<INode> = null) : IEdge;
		function destroyEdge(edge : IEdge) : void;
		function createNetwork() : INetwork;
		function get nodes() : Vector.<INode>;
		function get edges() : Vector.<IEdge>;
		function destroyAllEdges() : void;
		function get networks() : Vector.<INetwork>;
		function createEdgeInOut(node1 : INode, node2 : INode) : void;
		function createRandomInOutEdge() : void;
	}
}
