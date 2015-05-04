package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.types.data.MapElement;
   import flash.geom.Rectangle;
   import com.ankamagames.berilia.managers.SecureCenter;
   
   public class MapIconElement extends MapElement
   {
      
      public function MapIconElement(param1:String, param2:int, param3:int, param4:String, param5:Texture, param6:String, param7:*, param8:Boolean = true)
      {
         super(param1,param2,param3,param4,param7);
         this.texture = SecureCenter.secure(param5,false);
         this.legend = param6;
         this.canBeManuallyRemoved = param8;
         this._texture = param5;
         param5.mouseEnabled = true;
      }
      
      public var texture:Object;
      
      public var legend:String;
      
      public var follow:Boolean;
      
      public var canBeGrouped:Boolean = true;
      
      public var canBeAutoSize:Boolean = true;
      
      public var canBeManuallyRemoved:Boolean = true;
      
      private var _boundsRef:Texture;
      
      public function get bounds() : Rectangle
      {
         return this._boundsRef?this._boundsRef.getStageRect():this._texture?this._texture.getStageRect():null;
      }
      
      public function set boundsRef(param1:Texture) : void
      {
         this._boundsRef = param1;
      }
      
      var _texture:Texture;
      
      override public function remove() : void
      {
         if(this._texture)
         {
            this._texture.remove();
            if(this._texture.parent)
            {
               this._texture.parent.removeChild(this._texture);
            }
         }
         this._texture = null;
         SecureCenter.destroy(this.texture);
         this.texture = null;
         super.remove();
      }
   }
}
