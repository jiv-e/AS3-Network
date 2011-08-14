package fi.validi.network.model {
	import flash.events.EventDispatcher;

	/**
	 * @author Juho Viitasalo
	 */
	public class Network extends EventDispatcher implements INetwork {
		private static var _IDCounter : uint = 1;
		private var _ID : uint;
		private var _nodes : Vector.<INode>;
		private var _edges : Vector.<IEdge>;
		
		public function Network() {
			_ID = _IDCounter;
			_IDCounter++;
			_edges = new Vector.<IEdge>;
			_nodes = new Vector.<INode>;
			trace("Network created (ID: " + _ID + ")");
		}

		public function destroy() : void {
		}

		public function sendEffect(effect : IEffect) : void {
		}

		public function enable() : void {
		}

		public function disable() : void {
		}

		public function get numberOfNodes() : uint {
			return _nodes.length;
		}

		public function get numberOfEdges() : uint {
			// TODO: Auto-generated method stub
			return 0;
		}

		public function get ID() : uint {
			return _ID;
		}

		public function addObject(object : INetObject) : void {
			trace((object));
			
		}

		public function get nodes() : Vector.<INode> {
			return _nodes;
		}


		public function addNode(node : INode) : void {
			if(nodes.indexOf(node) == -1) {
				nodes.push(node);
				trace("Node " + node.ID + " added to network " + this.ID + ".");
				
			}
			else {
				trace("Node " + node.ID + " is already in network " + this.ID + ".");				
			}

		}

		public function addEdge(edge : IEdge) : void {
			if(edges.indexOf(edge) == -1) {
				edges.push(edge);
				trace("Edge " + edge.ID + " added to network " + this.ID + ".");
			}
			else {
				trace("Edge " + edge.ID + " is already in network " + this.ID + ".");				
			}
		}

		public function removeNode(node : INode) : Boolean {
			var index : int = nodes.indexOf(node);
			if(index == -1) {
				trace("Node " + node.ID + " not found from network " + this.ID + " when tried to remove.");
				return false;
			}
			else {
				nodes.splice(index, 1);
				trace("Node " + node.ID + " removed from network " + this.ID + ".");
				return true;	
			}
		}

		public function removeEdge(edge : IEdge) : Boolean {
			var index : int = edges.indexOf(edge);
			if(index == -1) {
				trace("Edge " + edge.ID + " not found from network " + this.ID + " when tried to remove.");
				return false;
			}
			else {
				edges.splice(index, 1);
				trace("Edge " + edge.ID + " removed from network " + this.ID + ".");
				return true;	
			}
		}

		public function get edges() : Vector.<IEdge> {
			return _edges;
		}

		public function removeAllNodes() : void {	
			for each (var node : INode in nodes) {
				removeNode(node);
			}
		}

		public function removeAllEdges(edge : IEdge) : void {
			for each (var edge : IEdge in edges) {
				removeEdge(edge);
			}
		}
		
		override public function toString() : String {
			return String(ID);
		}
		
		public function cascade() : void {
			
		}
		
	}
}
