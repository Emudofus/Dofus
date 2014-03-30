package com.ankamagames.berilia.components.gridRenderer
{
   import flash.display.DisplayObject;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import flash.display.DisplayObjectContainer;
   import com.ankamagames.berilia.managers.SecureCenter;
   import flash.geom.ColorTransform;
   
   public class InlineXmlGridRender extends MultiGridRenderer
   {
      
      public function InlineXmlGridRender(args:String) {
         super(null);
         var params:Array = args.split(",");
         _updateFunctionName = params[0];
         if(params[1])
         {
            _bgColor1 = new ColorTransform();
            _color1 = parseInt(params[1],16);
            _bgColor1.color = _color1;
         }
         if(params[2])
         {
            _bgColor2 = new ColorTransform();
            _color2 = parseInt(params[2],16);
            _bgColor2.color = _color2;
         }
         if(params[3])
         {
            _bgAlpha = Number(params[3]);
         }
         _defaultLineType = "default";
      }
      
      override public function update(data:*, index:uint, target:DisplayObject, selected:Boolean, subIndex:uint=0) : void {
         super.update(data,index,target,selected,subIndex);
      }
      
      override protected function uiUpdate(ui:UiRootContainer, target:DisplayObject, data:*, selected:Boolean, subIndex:uint) : void {
         if(DisplayObjectContainer(target).numChildren)
         {
            ui.uiClass[_updateFunctionName](SecureCenter.secure(data),_cptNameReferences[DisplayObjectContainer(target).getChildAt(0)],selected);
         }
      }
      
      override public function renderModificator(childs:Array) : Array {
         _containerDefinition["default"] = childs[0];
         return [];
      }
   }
}
