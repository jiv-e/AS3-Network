package fi.validi.network.view.view2d {
	import flash.events.Event;
	import com.greensock.OverwriteManager;
	import com.greensock.TimelineLite;
	import com.greensock.TimelineMax;
	import com.greensock.TweenAlign;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.TweenNano;
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.BevelFilterPlugin;
	import com.greensock.plugins.BezierPlugin;
	import com.greensock.plugins.BezierThroughPlugin;
	import com.greensock.plugins.BlurFilterPlugin;
	import com.greensock.plugins.CacheAsBitmapPlugin;
	import com.greensock.plugins.CirclePath2DPlugin;
	import com.greensock.plugins.ColorMatrixFilterPlugin;
	import com.greensock.plugins.ColorTransformPlugin;
	import com.greensock.plugins.DropShadowFilterPlugin;
	import com.greensock.plugins.EndArrayPlugin;
	import com.greensock.plugins.EndVectorPlugin;
	import com.greensock.plugins.FilterPlugin;
	import com.greensock.plugins.FrameBackwardPlugin;
	import com.greensock.plugins.FrameForwardPlugin;
	import com.greensock.plugins.FrameLabelPlugin;
	import com.greensock.plugins.FramePlugin;
	import com.greensock.plugins.GlowFilterPlugin;
	import com.greensock.plugins.HexColorsPlugin;
	import com.greensock.plugins.QuaternionsPlugin;
	import com.greensock.plugins.RemoveTintPlugin;
	import com.greensock.plugins.RoundPropsPlugin;
	import com.greensock.plugins.ScalePlugin;
	import com.greensock.plugins.ScrollRectPlugin;
	import com.greensock.plugins.SetActualSizePlugin;
	import com.greensock.plugins.SetSizePlugin;
	import com.greensock.plugins.ShortRotationPlugin;
	import com.greensock.plugins.SoundTransformPlugin;
	import com.greensock.plugins.StageQualityPlugin;
	import com.greensock.plugins.TintPlugin;
	import com.greensock.plugins.TransformMatrixPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.plugins.VisiblePlugin;
	import com.greensock.plugins.VolumePlugin;
	import fi.validi.network.model.INetwork;
	import fi.validi.network.model.INode;
	import fi.validi.network.model.Network;
	import fi.validi.network.model.model2d.INode2D;
	import fi.validi.network.model.model2d.Node2D;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.text.TextField;

	/**
	 * @author Juho Viitasalo
	 */
	public class NodeSprite2D extends Sprite {
		private var _oiriginalFillColor:uint = 0xFFCC00;
		private var _fillColor:uint = 0xFFCC00;
        private var _mouseOverColor:uint = 0xFF0000;
        private var _strokeColor:uint = 0x000000;
        private var _strokeThickness:int = 1;
		private var _fill:Shape;
		private var _stroke:Shape;
		
		private static var _radius : Number = 5;
		private var _upscale : Number = 1.2;
		private var _mouseOutDuration : Number = 0.5;
		private var _mouseOverDuration : Number = 0.1;
		
		private var _colorTransform : ColorTransform;
		
		private var _active : Boolean = false;
		
		private var _nodeData : INode2D;
		
		private var textField : TextField;
		private var _withLabel : Boolean;
		
		public function NodeSprite2D(node : INode2D, withLabel : Boolean = false) {
			_nodeData = node;
			_withLabel = withLabel;
			if (stage) draw();
			else addEventListener(Event.ADDED_TO_STAGE, init);			
		}

		private function init(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			draw();
		}

		private function draw() : void {
			this.x = _nodeData.xProportional*stage.width;
			this.y = _nodeData.yProportional*stage.height;
			drawCircleFill();
			drawCircleStroke();
			_colorTransform = new ColorTransform();
			addListeners();
			if(_withLabel) {
				addText(String(_nodeData.ID));
			}
		}
		
		private function addListeners():void {
			addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
		}
		
		private function mouseOutHandler(e:MouseEvent):void {
			removeText();
			deactivate();
		}

		
		private function mouseOverHandler(e:MouseEvent):void {
			addText(_nodeData.networkIDs.join());
			
			activate();
		}
		
		private function drawCircleFill():void {
            _fill = new Shape();
            _fill.graphics.beginFill(_oiriginalFillColor);
            _fill.graphics.drawCircle(0, 0, _radius);
            _fill.graphics.endFill();
            addChild(_fill);
        }
		
		private function drawCircleStroke():void {
            _stroke = new Shape();
            _stroke.graphics.lineStyle(_strokeThickness, _strokeColor);
            _stroke.graphics.drawCircle(0, 0, _radius);
            addChild(_stroke);
        }
		
		public function get fillColor():uint { return _fillColor; }
		
		public function set fillColor(value:uint):void 
		{
			_fillColor = value;
			_colorTransform.color = _fillColor;
			_fill.transform.colorTransform = _colorTransform;
		}
		
		public static function get radius():Number { return _radius; }
		
		public static function set radius(value:Number):void {
			_radius = value;
		}
		
		public function get active():Boolean { return _active; }
		
		public function set active(value:Boolean):void 
		{
			if (_active != value) {
				_active = value;
				if (_active) activate();
				else deactivate();
			}
		}
		
		

//		
//		public function addEdge(edge : EdgeSprite):void {
//			_edges.push(edge);
//		}
//		
//		public function removeEdge(edge : EdgeSprite):void {
//			_edges.splice(_edges.indexOf(edge),1);
//		}
//		
//		public function addNeighbourNode(node : NodeSprite) : void {
//			_neighbourNodes.push(node);
//		}
//		
//		public function removeNeighbourNode(node : NodeSprite) : void {
//			_neighbourNodes.splice(_neighbourNodes.indexOf(node), 1);
//		}
		
		private function activate() : void {
			//TweenLite.to(this, _mouseOverDuration, { scaleX:_upscale, scaleY:_upscale, hexColors: { currentFillColor: _mouseOverColor }} );
			fillColor = _mouseOverColor;
//			for (var i : int = 0; i < _edges.length; i++) {
//				_edges[i].active = true;
//			}
		}
		
		private function deactivate() : void {
			//TweenLite.to(this, _mouseOutDuration, { scaleX:1, scaleY:1, hexColors: { currentFillColor: _fillColor }} );
			fillColor = _oiriginalFillColor;
//			for (var i : int = 0; i < _edges.length; i++) {
//				_edges[i].active = false;
//			}
		}
		
//		public function isNeighbour(node : NodeSprite) : Boolean {
//			return this.neighbourNodes.indexOf(node) != -1;
//		}
		
		public function remove() :void {
//			while (_edges.length != 0) {
//				_edges.pop().remove;
//			}
//			_nodeCount--;
//			parent.removeChild(this);
		}
		
		private function addText(string : String) : void {
			textField = new TextField();
			textField.text = string;
			textField.scaleX = 2;
			textField.scaleY = 2;
			addChild(textField);
		}
		
		private function removeText() : void {
			removeChild(textField);
		}
		
	}
}
