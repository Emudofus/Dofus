package com.ankamagames.berilia.components.gridRenderer
{
   import com.ankamagames.berilia.interfaces.IGridRenderer;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.display.Sprite;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.components.Grid;
   import flash.geom.ColorTransform;
   import flash.utils.Dictionary;
   import flash.display.DisplayObject;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.berilia.types.event.UiRenderEvent;
   import com.ankamagames.berilia.utils.errors.BeriliaError;
   import com.ankamagames.berilia.components.params.GridScriptProperties;
   import com.ankamagames.berilia.managers.SecureCenter;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.berilia.UIComponent;
   import flash.display.Shape;
   import flash.geom.Transform;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.data.UiModule;
   
   public class XmlUiGridRenderer extends Object implements IGridRenderer
   {
      
      public function XmlUiGridRenderer(param1:String) {
         var _loc4_:Array = null;
         this._log = Log.getLogger(getQualifiedClassName(XmlUiGridRenderer));
         this._berilia = Berilia.getInstance();
         this._shapeIndex = new Dictionary(true);
         this._dWaitingUpdate = new Dictionary(true);
         super();
         var _loc2_:Array = param1.split(",");
         var _loc3_:String = _loc2_[0];
         if(_loc2_[1])
         {
            this._bgColor1 = new ColorTransform();
            this._bgColor1.color = parseInt(_loc2_[1],16);
         }
         if(_loc2_[2])
         {
            this._bgColor2 = new ColorTransform();
            this._bgColor2.color = parseInt(_loc2_[2],16);
         }
         if(_loc3_.indexOf("::") != -1)
         {
            _loc4_ = _loc3_.split("::");
            if(UiModuleManager.getInstance().getModules()[_loc4_[0]])
            {
               this._sUiModule = _loc4_[0];
               if(UiModule(UiModuleManager.getInstance().getModules()[_loc4_[0]]).uis[_loc4_[1]])
               {
                  this._sUiName = _loc4_[1];
               }
               else
               {
                  throw new BeriliaError("Ui [" + _loc4_[1] + "] does not exit in module [" + _loc4_[0] + "] (grid parameter name [" + _loc3_ + "])");
               }
            }
            else
            {
               throw new BeriliaError("Module [" + _loc4_[0] + "] does not exit (grid parameter name [" + _loc3_ + "])");
            }
         }
         else
         {
            this._sUiName = _loc3_;
         }
      }
      
      protected var _log:Logger;
      
      private var _sUiName:String;
      
      private var _sUiModule:String;
      
      private var _ctr:Sprite;
      
      private var _berilia:Berilia;
      
      private var _uiCtr:UiRootContainer;
      
      private var _grid:Grid;
      
      private var _bgColor1:ColorTransform;
      
      private var _bgColor2:ColorTransform;
      
      private var _shapeIndex:Dictionary;
      
      private var _dWaitingUpdate:Dictionary;
      
      public function set grid(param1:Grid) : void {
         this._grid = param1;
      }
      
      public function render(param1:*, param2:uint, param3:Boolean, param4:uint=0) : DisplayObject {
         var _loc5_:UiRootContainer = this._grid.getUi();
         this._uiCtr = new UiRootContainer(StageShareManager.stage,_loc5_.uiModule.uis[this._sUiName],this._ctr);
         this._uiCtr.uiModule = _loc5_.uiModule;
         this._uiCtr.addEventListener(UiRenderEvent.UIRenderComplete,this.onItemUiLoaded);
         this._uiCtr.mouseEnabled = true;
         if(!_loc5_.uiModule.uis[this._sUiName])
         {
            throw new BeriliaError("Ui [" + this._sUiName + "] does not exit in module [" + this._uiCtr.uiModule.id + "] (grid parameter name [" + this._sUiName + "])");
         }
         else
         {
            this.updateBackground(this._uiCtr,param2);
            this._berilia.loadUiInside(_loc5_.uiModule.uis[this._sUiName],this._uiCtr.name,this._uiCtr,new GridScriptProperties(param1,param3,this._grid));
            return this._uiCtr;
         }
      }
      
      public function update(param1:*, param2:uint, param3:DisplayObject, param4:Boolean, param5:uint=0) : void {
         if(param3 is UiRootContainer)
         {
            if((UiRootContainer(param3).ready) && (Object(UiRootContainer(param3).uiClass)))
            {
               if(!(Object(UiRootContainer(param3).uiClass).data == null) || !(param1 == null))
               {
                  this.updateBackground(UiRootContainer(param3),param2);
                  Object(UiRootContainer(param3).uiClass).update(SecureCenter.secure(param1),param4);
               }
            }
            else
            {
               this._dWaitingUpdate[param3] = new WaitingUpdate(param1,param2,param3,param4,true);
            }
         }
         else
         {
            this._log.warn("Can\'t update, " + param3.name + " is not a SecureUi");
         }
      }
      
      public function getDataLength(param1:*, param2:Boolean) : uint {
         return 1;
      }
      
      public function remove(param1:DisplayObject) : void {
         if(param1 is UiRootContainer)
         {
            Berilia.getInstance().unloadUi(UiRootContainer(param1).name);
         }
      }
      
      public function destroy() : void {
         this._berilia = null;
         this._uiCtr = null;
         this._grid = null;
      }
      
      public function renderModificator(param1:Array) : Array {
         return param1;
      }
      
      public function eventModificator(param1:Message, param2:String, param3:Array, param4:UIComponent) : String {
         return param2;
      }
      
      private function onItemUiLoaded(param1:UiRenderEvent) : void {
         var _loc2_:WaitingUpdate = null;
         if(this._dWaitingUpdate[param1.uiTarget])
         {
            _loc2_ = this._dWaitingUpdate[param1.uiTarget];
            this.update(_loc2_.data,_loc2_.index,_loc2_.dispObj,_loc2_.selected);
            this._dWaitingUpdate[param1.uiTarget] = null;
         }
      }
      
      private function updateBackground(param1:UiRootContainer, param2:uint) : void {
         var _loc3_:ColorTransform = null;
         var _loc4_:Shape = null;
         if((this._bgColor1) || (this._bgColor2))
         {
            if(!this._shapeIndex[param1])
            {
               _loc4_ = new Shape();
               _loc4_.graphics.beginFill(16777215);
               _loc4_.graphics.drawRect(0,0,this._grid.slotWidth,this._grid.slotHeight);
               this._uiCtr.getStrata(0).addChild(_loc4_);
               this._shapeIndex[param1] = 
                  {
                     "trans":new Transform(_loc4_),
                     "shape":_loc4_
                  };
            }
            _loc3_ = param2 % 2?this._bgColor1:this._bgColor2;
            DisplayObject(this._shapeIndex[param1].shape).visible = !(_loc3_ == null);
            if(_loc3_)
            {
               Transform(this._shapeIndex[param1].trans).colorTransform = _loc3_;
            }
         }
      }
   }
}
import flash.display.DisplayObject;

class WaitingUpdate extends Object
{
   
   function WaitingUpdate(param1:*, param2:uint, param3:DisplayObject, param4:Boolean, param5:Boolean) {
      super();
      this.data = param1;
      this.selected = param4;
      this.drawBackground = param5;
      this.dispObj = param3;
      this.index = param2;
   }
   
   public var data;
   
   public var index;
   
   public var selected:Boolean;
   
   public var drawBackground:Boolean;
   
   public var dispObj:DisplayObject;
}
