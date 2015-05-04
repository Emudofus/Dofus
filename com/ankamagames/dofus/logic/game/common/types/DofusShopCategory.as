package com.ankamagames.dofus.logic.game.common.types
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class DofusShopCategory extends DofusShopObject implements IDataCenter
   {
      
      public function DofusShopCategory(param1:Object)
      {
         super(param1);
      }
      
      private var _displaymode:String;
      
      private var _key:String;
      
      private var _image:String;
      
      private var _child:Array;
      
      override public function init(param1:Object) : void
      {
         var _loc2_:Object = null;
         super.init(param1);
         this._displaymode = param1.displaymode;
         this._key = param1.key;
         if(param1.image)
         {
            this._image = param1.image;
         }
         if(param1.child)
         {
            this._child = new Array();
            for each(_loc2_ in param1.child)
            {
               this._child.push(new DofusShopCategory(_loc2_));
            }
         }
      }
      
      override public function free() : void
      {
         var _loc1_:DofusShopCategory = null;
         this._displaymode = null;
         this._key = null;
         if(this._child)
         {
            for each(_loc1_ in this._child)
            {
               _loc1_.free();
            }
            this._child = null;
         }
         super.free();
      }
      
      public function get key() : String
      {
         return this._key;
      }
      
      public function get image() : String
      {
         return this._image;
      }
      
      public function get children() : Array
      {
         return this._child;
      }
   }
}
