package com.ankamagames.berilia.components.gridRenderer
{
   import com.ankamagames.berilia.interfaces.IGridRenderer;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.berilia.components.Grid;
   import flash.geom.ColorTransform;
   import com.ankamagames.jerakine.types.Uri;
   import flash.utils.Dictionary;
   import flash.display.DisplayObject;
   import com.ankamagames.berilia.types.data.TreeData;
   import flash.display.Sprite;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.Label;
   import flash.events.MouseEvent;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.berilia.UIComponent;
   import flash.display.Shape;
   import flash.geom.Transform;
   import com.ankamagames.jerakine.interfaces.IInterfaceListener;
   import com.ankamagames.berilia.components.Tree;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class TreeGridRenderer extends Object implements IGridRenderer
   {
      
      public function TreeGridRenderer(param1:String) {
         var _loc2_:Array = null;
         this._log = Log.getLogger(getQualifiedClassName(TreeGridRenderer));
         this._shapeIndex = new Dictionary(true);
         this._indexRef = new Dictionary(true);
         this._uriRef = new Array();
         super();
         if(param1)
         {
            _loc2_ = param1.length?param1.split(","):null;
            if((_loc2_[0]) && (_loc2_[0].length))
            {
               this._cssUri = new Uri(_loc2_[0]);
            }
            if((_loc2_[1]) && (_loc2_[1].length))
            {
               this._bgColor1 = new ColorTransform();
               this._bgColor1.color = parseInt(_loc2_[1],16);
            }
            if((_loc2_[2]) && (_loc2_[2].length))
            {
               this._bgColor2 = new ColorTransform();
               this._bgColor2.color = parseInt(_loc2_[2],16);
            }
            if((_loc2_[3]) && (_loc2_[3].length))
            {
               this._overColor = new ColorTransform();
               this._overColor.color = parseInt(_loc2_[3],16);
            }
            if((_loc2_[4]) && (_loc2_[4].length))
            {
               this._selectedColor = new ColorTransform();
               this._selectedColor.color = parseInt(_loc2_[4],16);
            }
            if((_loc2_[5]) && (_loc2_[5].length))
            {
               this._expendBtnUri = new Uri(_loc2_[5]);
            }
            if((_loc2_[6]) && (_loc2_[6].length))
            {
               this._simpleItemUri = new Uri(_loc2_[6]);
            }
            if((_loc2_[7]) && (_loc2_[7].length))
            {
               this._endItemUri = new Uri(_loc2_[7]);
            }
         }
      }
      
      protected var _log:Logger;
      
      private var _grid:Grid;
      
      private var _bgColor1:ColorTransform;
      
      private var _bgColor2:ColorTransform;
      
      private var _selectedColor:ColorTransform;
      
      private var _overColor:ColorTransform;
      
      private var _cssUri:Uri;
      
      private var _expendBtnUri:Uri;
      
      private var _simpleItemUri:Uri;
      
      private var _endItemUri:Uri;
      
      private var _shapeIndex:Dictionary;
      
      private var _indexRef:Dictionary;
      
      private var _uriRef:Array;
      
      public function set grid(param1:Grid) : void {
         this._grid = param1;
      }
      
      public function render(param1:*, param2:uint, param3:Boolean, param4:uint=0) : DisplayObject {
         var _loc6_:TreeData = null;
         var _loc5_:Sprite = new Sprite();
         _loc5_.mouseEnabled = false;
         this._indexRef[_loc5_] = param1;
         _loc6_ = param1;
         var _loc7_:Texture = new Texture();
         _loc7_.mouseEnabled = true;
         _loc7_.width = 10;
         _loc7_.height = this._grid.slotHeight + 1;
         _loc7_.y = (this._grid.slotHeight - 18) / 2;
         if(_loc6_)
         {
            _loc7_.x = _loc6_.depth * _loc7_.width;
            if((_loc6_.children) && (_loc6_.children.length))
            {
               _loc7_.uri = this._expendBtnUri;
               _loc7_.buttonMode = true;
            }
            else
            {
               if(_loc6_.parent.children.indexOf(_loc6_) == _loc6_.parent.children.length-1)
               {
                  _loc7_.uri = this._endItemUri;
               }
               else
               {
                  _loc7_.uri = this._simpleItemUri;
               }
            }
            if(_loc6_.expend)
            {
               _loc7_.gotoAndStop = "selected";
            }
            else
            {
               _loc7_.gotoAndStop = "normal";
            }
         }
         _loc7_.finalize();
         var _loc8_:Label = new Label();
         _loc8_.mouseEnabled = true;
         _loc8_.useHandCursor = true;
         _loc8_.x = _loc7_.x + _loc7_.width + 3;
         _loc8_.width = this._grid.slotWidth - _loc8_.x;
         _loc8_.height = this._grid.slotHeight;
         if((param1) && (param1.value.hasOwnProperty("css")))
         {
            if(param1.css is String)
            {
               if(!this._uriRef[param1.value.css])
               {
                  this._uriRef[param1.value.css] = new Uri(param1.value.css);
               }
               _loc8_.css = this._uriRef[param1.value.css];
            }
            else
            {
               _loc8_.css = param1.value.css;
            }
            if(param1.value.hasOwnProperty("cssClass"))
            {
               _loc8_.cssClass = param1.value.cssClass;
            }
         }
         if(param1 is String || param1 == null)
         {
            _loc8_.text = param1;
         }
         else
         {
            _loc8_.text = param1.label;
         }
         if(this._cssUri)
         {
            _loc8_.css = this._cssUri;
         }
         this.updateBackground(_loc5_,param2,param3);
         _loc8_.addEventListener(MouseEvent.MOUSE_OVER,this.onRollOver);
         _loc8_.addEventListener(MouseEvent.MOUSE_OUT,this.onRollOut);
         _loc7_.addEventListener(MouseEvent.CLICK,this.onRelease);
         _loc8_.finalize();
         _loc5_.addChild(_loc7_);
         _loc5_.addChild(_loc8_);
         return _loc5_;
      }
      
      public function getDataLength(param1:*, param2:Boolean) : uint {
         return 1;
      }
      
      public function update(param1:*, param2:uint, param3:DisplayObject, param4:Boolean, param5:uint=0) : void {
         var _loc6_:TreeData = null;
         var _loc7_:Texture = null;
         var _loc8_:Label = null;
         if(param3 is Sprite)
         {
            _loc6_ = param1;
            this._indexRef[param3] = _loc6_;
            _loc7_ = Sprite(param3).getChildAt(1) as Texture;
            _loc8_ = Sprite(param3).getChildAt(2) as Label;
            if(_loc6_ != null)
            {
               _loc7_.x = _loc6_.depth * 10 + 3;
               if((_loc6_.children) && (_loc6_.children.length))
               {
                  _loc7_.uri = this._expendBtnUri;
                  if(_loc6_.expend)
                  {
                     _loc7_.gotoAndStop = "selected";
                  }
                  else
                  {
                     _loc7_.gotoAndStop = "normal";
                  }
               }
               else
               {
                  if(_loc6_.parent.children.indexOf(_loc6_) == _loc6_.parent.children.length-1)
                  {
                     _loc7_.uri = this._endItemUri;
                  }
                  else
                  {
                     _loc7_.uri = this._simpleItemUri;
                  }
               }
               _loc8_.x = _loc7_.x + _loc7_.width + 3;
               _loc8_.width = this._grid.slotWidth - _loc8_.x;
               _loc8_.css = this._cssUri;
               _loc8_.cssClass = "";
               if((param1) && (param1.value.hasOwnProperty("css")))
               {
                  if(param1.value.css is String)
                  {
                     if(!this._uriRef[param1.value.css])
                     {
                        this._uriRef[param1.value.css] = new Uri(param1.value.css);
                     }
                     _loc8_.css = this._uriRef[param1.value.css];
                  }
                  else
                  {
                     _loc8_.css = param1.value.css;
                  }
                  if(param1.value.hasOwnProperty("cssClass"))
                  {
                     _loc8_.cssClass = param1.value.cssClass;
                  }
               }
               _loc8_.text = _loc6_.label;
               _loc8_.finalize();
            }
            else
            {
               _loc8_.text = "";
               _loc7_.uri = null;
            }
            this.updateBackground(param3 as Sprite,param2,param4);
         }
         else
         {
            this._log.warn("Can\'t update, " + param3.name + " is not a Sprite");
         }
      }
      
      public function remove(param1:DisplayObject) : void {
         var _loc2_:Label = null;
         this._indexRef[param1] = null;
         if(param1 is Label)
         {
            _loc2_ = param1 as Label;
            if(_loc2_.parent)
            {
               _loc2_.parent.removeChild(param1);
            }
            _loc2_.removeEventListener(MouseEvent.MOUSE_OUT,this.onRollOut);
            _loc2_.removeEventListener(MouseEvent.MOUSE_OVER,this.onRollOver);
         }
      }
      
      public function destroy() : void {
         this._grid = null;
         this._shapeIndex = null;
      }
      
      public function renderModificator(param1:Array) : Array {
         return param1;
      }
      
      public function eventModificator(param1:Message, param2:String, param3:Array, param4:UIComponent) : String {
         return param2;
      }
      
      private function updateBackground(param1:Sprite, param2:uint, param3:Boolean) : void {
         var _loc5_:Shape = null;
         if(!this._shapeIndex[param1])
         {
            _loc5_ = new Shape();
            _loc5_.graphics.beginFill(16777215);
            _loc5_.graphics.drawRect(0,0,this._grid.slotWidth,this._grid.slotHeight + 1);
            param1.addChildAt(_loc5_,0);
            this._shapeIndex[param1] = 
               {
                  "trans":new Transform(_loc5_),
                  "shape":_loc5_
               };
         }
         var _loc4_:ColorTransform = param2 % 2?this._bgColor1:this._bgColor2;
         if((param3) && (this._selectedColor))
         {
            _loc4_ = this._selectedColor;
         }
         this._shapeIndex[param1].currentColor = _loc4_;
         DisplayObject(this._shapeIndex[param1].shape).visible = !(_loc4_ == null);
         if(_loc4_)
         {
            Transform(this._shapeIndex[param1].trans).colorTransform = _loc4_;
         }
      }
      
      private function onRollOver(param1:MouseEvent) : void {
         var _loc2_:Sprite = null;
         if(param1.target.name.indexOf("extension") == -1 && (param1.target.text.length))
         {
            _loc2_ = param1.target.parent as Sprite;
            if(this._overColor)
            {
               Transform(this._shapeIndex[_loc2_].trans).colorTransform = this._overColor;
               DisplayObject(this._shapeIndex[_loc2_].shape).visible = true;
            }
         }
      }
      
      private function onRollOut(param1:MouseEvent) : void {
         var _loc2_:Sprite = null;
         if(param1.target.name.indexOf("extension") == -1)
         {
            _loc2_ = param1.target.parent as Sprite;
            if(this._shapeIndex[_loc2_])
            {
               if(this._shapeIndex[_loc2_].currentColor)
               {
                  Transform(this._shapeIndex[_loc2_].trans).colorTransform = this._shapeIndex[_loc2_].currentColor;
               }
               DisplayObject(this._shapeIndex[_loc2_].shape).visible = !(this._shapeIndex[_loc2_].currentColor == null);
            }
         }
      }
      
      private function onRelease(param1:MouseEvent) : void {
         var _loc3_:IInterfaceListener = null;
         var _loc2_:TreeData = this._indexRef[param1.target.parent];
         _loc2_.expend = !_loc2_.expend;
         Tree(this._grid).rerender();
         for each (_loc3_ in Berilia.getInstance().UISoundListeners)
         {
            _loc3_.playUISound("16004");
         }
      }
   }
}
