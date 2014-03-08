package com.ankamagames.berilia.components.gridRenderer
{
   import flash.display.DisplayObject;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import flash.display.DisplayObjectContainer;
   import com.ankamagames.berilia.managers.SecureCenter;
   import flash.geom.ColorTransform;
   
   public class InlineXmlGridRender extends MultiGridRenderer
   {
      
      public function InlineXmlGridRender(param1:String) {
         super(null);
         var _loc2_:Array = param1.split(",");
         _updateFunctionName = _loc2_[0];
         if(_loc2_[1])
         {
            _bgColor1 = new ColorTransform();
            _color1 = parseInt(_loc2_[1],16);
            _bgColor1.color = _color1;
         }
         if(_loc2_[2])
         {
            _bgColor2 = new ColorTransform();
            _color2 = parseInt(_loc2_[2],16);
            _bgColor2.color = _color2;
         }
         _defaultLineType = "default";
      }
      
      override public function update(param1:*, param2:uint, param3:DisplayObject, param4:Boolean, param5:uint=0) : void {
         super.update(param1,param2,param3,param4,param5);
      }
      
      override protected function uiUpdate(param1:UiRootContainer, param2:DisplayObject, param3:*, param4:Boolean, param5:uint) : void {
         if(DisplayObjectContainer(param2).numChildren)
         {
            param1.uiClass[_updateFunctionName](SecureCenter.secure(param3),_cptNameReferences[DisplayObjectContainer(param2).getChildAt(0)],param4);
         }
      }
      
      override public function renderModificator(param1:Array) : Array {
         _containerDefinition["default"] = param1[0];
         return [];
      }
   }
}
