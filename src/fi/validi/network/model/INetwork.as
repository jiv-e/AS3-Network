package fi.validi.network.model {
	/**
	 * @author Juho Viitasalo
	 */
	public interface INetwork extends INetObject {
		function get numberOfNodes() : uint;
		function get numberOfEdges() : uint;
		function get nodes() : Vector.<INode>;
		function get edges() : Vector.<IEdge>;
		function get netWorld() : INetWorld;

		function addNode(node : INode) : void;
		function removeNode(node : INode) : Boolean;
		function removeAllNodes() : void;
		function addEdge(edge : IEdge) : void;
		function removeEdge(edge : IEdge) : Boolean;
		function removeAllEdges(edge : IEdge) : void;
		function toString() : String;

	}
}
