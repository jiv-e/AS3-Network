package 
{
	import flare.vis.data.ScaleBinding;
	import flash.display.DisplayObject;
	import fi.validi.network.model.Network;
	import flare.vis.operator.encoder.PropertyEncoder;
	import flare.scale.ScaleType;
	import flare.vis.operator.encoder.ColorEncoder;
	import flare.vis.operator.layout.AxisLayout;
	import flash.geom.Rectangle;
	import flare.vis.Visualization;
	import flare.util.Dates;
	import flare.vis.data.Data;
	import fi.validi.network.model.NetWorldEvent;
	import flash.text.TextField;
	import fi.validi.network.model.INetObject;
	import fi.validi.network.VectorOperations;
	import fi.validi.network.model.INetwork;
	import fi.validi.network.controller.NetWorldController2D;
	import com.bit101.components.NumericStepper;
	import flash.display.Shape;
	import fi.validi.network.model.model2d.NetWorld2D;
	import fi.validi.network.model.IEdge;
	import fi.validi.network.model.INode;
	import fi.validi.network.model.NetWorld;
	import fi.validi.network.model.model2d.Node2D;
	import fi.validi.network.view.view2d.NetWorldView2D;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;

	public class Main extends Sprite
	{
		private var _nodesStepper: NumericStepper;
		private var _edgesStepper: NumericStepper;

		
		private var _data : NetWorld2D;
		private var _view : NetWorldView2D;
		private var _controller : NetWorldController2D;
		private var vis : Visualization;
		private var _graphData : Data;
		private var _networldContainer : Sprite;
		private var axis : AxisLayout;
		
		public function Main()
		{
			// Launch your application by right clicking within this class and select: Deubg As > FDT SWF Application
			//var node : Node = new Node();

			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);	
			//_net = new NetworkSprite();
			//addChild(_net);
			
			_networldContainer = new Sprite();
            _networldContainer.graphics.beginFill(0xdddddd);
            _networldContainer.graphics.drawRect(0, 0, 500, 500);
            _networldContainer.graphics.endFill();
			addChild(_networldContainer);
			
			_nodesStepper = new NumericStepper(this, 600, 300, stepperHandler);
			_nodesStepper.maximum = 3000;
			_nodesStepper.minimum = 0;
			addChild(_nodesStepper);
			
			_edgesStepper = new NumericStepper(this, 600, 200, stepperHandler);
			_edgesStepper.maximum = 3000;
			_edgesStepper.minimum = 0;
			addChild(_edgesStepper);

			

			_data = new NetWorld2D();
			_view = new NetWorldView2D(_data);
			_controller = new NetWorldController2D(_data);
			_networldContainer.addChild(_view);
			var n1 : INode = _data.createNode2D(Math.random(), Math.random());
			var n2 : INode = _data.createNode2D(Math.random(), Math.random());
			var n3 : INode = _data.createNode2D(Math.random(), Math.random());
			
//			var nv1 : Vector.<INetwork> = new Vector.<INetwork>();
//			var nv2 : Vector.<INetwork> = new Vector.<INetwork>();
//			nv1 = nv1.concat(n3.networks);
//			nv1 = nv1.concat(n1.networks);
//			nv2 = nv2.concat(n2.networks);
//			nv2 = nv2.concat(n3.networks);
//
//			var dif : Vector.<INetwork> = Vector.<INetwork>(VectorOperations.difference(Vector.<INetObject>(nv1), Vector.<INetObject>(nv2)));
//			
//			for each (var j : INetwork in dif) {
//				trace("ID : " + j.ID);
//			}
			
			for(var i : uint; i < 400; i++) {
				if(i%2 == 0) {
					n1 = _data.createNode2D(Math.random(), Math.random());
				}
				else {
					n2 = _data.createNode2D(Math.random(), Math.random());
				}
//				var v1 : Vector.<INode> = new Vector.<INode>;
//				var v2 : Vector.<INode> = new Vector.<INode>;
//
//				if(Math.random() < 0.5) {
//					v1.push(n1);
//					v2.push(n1);
//					v1.push(n2);
//					v2.push(n2);
//					var edge1 : IEdge = _data.createEdge(v1, v2);						
//				}
			}
			visualize(getData());
//			var tween:Tween = new Tween(_nodesLayer, 3, {rotation:360});
//    		tween.play();
		}
		
		private function stepperHandler(e : Event):void {
			if(e.target == _edgesStepper) {
				var delta : Number = e.target.value - _data.edges.length;
				if (delta > 0) _controller.addEdges(delta);
				else if (delta < 0) _controller.destroyEdges(-delta);
				addDataPoint();
	            updateGraph();	
				//removeAllEdges();
				//createEdges();
			}
			else if (e.target == _nodesStepper) {
				_controller.createRandomNode();
				
//				createAllNodes(_nodesStepper.value);
//				createAllEdges(_edgesStepper.value);
			}
		}
		
		private function getData() : Data {
			 var data : Data = new Data();
			 //data.addNode({series: 1, ratio: 0, largestSize: 0});
			 
			 //data.addNode({series: 1, ratio: 1.8, largestSize: 100});
			 _graphData = data;
			 return data;
		}
		
		private function visualize(data:Data):void{
	        vis = new Visualization(data);
	        vis.bounds = new Rectangle(0, 500, 600, 250);
	        vis.x = 40;
	        vis.y = 0;
	        addChildAt(vis,1);
	 		axis = new AxisLayout("data.ratio", "data.largestSize");
			vis.operators.add(axis);

			axis.xScale.zeroBased = true;    
			axis.yScale.zeroBased = true;
			    
			//axis.yScale.preferredMax = 400;    
			//axis.xScale.ignoreUpdates = true;
			//axis.yScale.ignoreUpdates = true;
			
			vis.operators.add(new ColorEncoder("data.series", Data.EDGES, "lineColor", ScaleType.CATEGORIES));
			vis.operators.add(new ColorEncoder("data.series", Data.NODES, "fillColor", ScaleType.CATEGORIES));
			vis.operators.add(new PropertyEncoder({lineWidth:2}, Data.EDGES));    

			updateGraph();
		}
		
		private function updateGraph() : void {
	   		vis.data.nodes.setProperties({fillColor:0, lineColor: 0x000000ff, lineWidth:0, size:0.3});
        	vis.update();
		}
		private function addDataPoint() : void {
			_graphData.addNode({series:1, ratio:_data.edges.length / _data.nodes.length, largestSize:Network.largest.nodes.length});
		}

	}
}
