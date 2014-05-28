package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.types.data.MapElement;
   import flash.geom.Rectangle;
   import com.ankamagames.berilia.managers.SecureCenter;
   
   public class MapIconElement extends MapElement
   {
      
      public function MapIconElement(id:String, x:int, y:int, layer:String, texture:Texture, legend:String, owner:*) {
         super(id,x,y,layer,owner);
         this.texture = SecureCenter.secure(texture,false);
         this.legend = legend;
         this._texture = texture;
         texture.mouseEnabled = true;
      }
      
      public var texture:Object;
      
      public var legend:String;
      
      public var follow:Boolean;
      
      public var canBeGrouped:Boolean = true;
      
      public var canBeAutoSize:Boolean = true;
      
      private var _boundsRef:Texture;
      
      public function get bounds() : Rectangle {
         return this._boundsRef?this._boundsRef.getStageRect():this._texture?this._texture.getStageRect():null;
      }
      
      public function set boundsRef(v:Texture) : void {
         this._boundsRef = v;
      }
      
      var _texture:Texture;
      
      override public function remove() : void {
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
