package com.ankamagames.dofus.types.entities
{
   import com.ankamagames.jerakine.interfaces.IObstacle;
   import flash.filters.GlowFilter;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.dofus.network.enums.GameActionMarkTypeEnum;
   import com.ankamagames.dofus.types.enums.PortalAnimationEnum;
   import com.ankamagames.jerakine.types.Color;
   import flash.display.Sprite;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   
   public class Glyph extends Projectile implements IObstacle
   {
      
      public function Glyph(param1:int, param2:TiphonEntityLook, param3:Boolean = false, param4:Boolean = true, param5:uint = 0)
      {
         super(param1,param2,param3,param4);
         this.glyphType = param5;
      }
      
      private static var GLOW_FILTER:GlowFilter;
      
      private static var CSS_URI:Uri;
      
      public var glyphType:uint;
      
      public var lbl_number:Label;
      
      public function canSeeThrough() : Boolean
      {
         return true;
      }
      
      public function canWalkThrough() : Boolean
      {
         var _loc1_:* = true;
         if(this.glyphType == GameActionMarkTypeEnum.PORTAL && !(getAnimation() == PortalAnimationEnum.STATE_DISABLED))
         {
            _loc1_ = false;
         }
         return _loc1_;
      }
      
      public function canWalkTo() : Boolean
      {
         return true;
      }
      
      public function addNumber(param1:int, param2:Color = null) : void
      {
         var _loc3_:Sprite = null;
         if(!this.lbl_number || this.lbl_number == null)
         {
            if(!CSS_URI)
            {
               CSS_URI = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "css/normal.css");
            }
            if(!GLOW_FILTER || !(GLOW_FILTER.color == param2.color) && !(param2 == null))
            {
               if(param2 == null)
               {
                  GLOW_FILTER = new GlowFilter(42986,0.9,3,3,6,3);
               }
               else
               {
                  GLOW_FILTER = new GlowFilter(param2.color,0.9,3,3,6,3);
               }
            }
            _loc3_ = new Sprite();
            this.lbl_number = new Label();
            this.lbl_number.width = 30;
            this.lbl_number.height = 20;
            this.lbl_number.x = -20;
            this.lbl_number.y = 14;
            this.lbl_number.cssClass = "light";
            this.lbl_number.css = CSS_URI;
            this.lbl_number.text = param1.toString();
            this.lbl_number.visible = false;
            _loc3_.addChild(this.lbl_number);
            _loc3_.filters = [GLOW_FILTER];
            this.addBackground("labelNumber",_loc3_);
         }
         else
         {
            this.lbl_number.text = param1.toString();
         }
      }
   }
}
