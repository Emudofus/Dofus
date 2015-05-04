package com.ankamagames.dofus.logic.game.common.types
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.types.enums.DofusShopEnum;
   
   public class DofusShopHighlight extends DofusShopObject implements IDataCenter
   {
      
      public function DofusShopHighlight(param1:Object)
      {
         super(param1);
      }
      
      private var _type:String;
      
      private var _mode:String;
      
      private var _link:String;
      
      private var _image:String;
      
      private var _external:Object;
      
      override public function init(param1:Object) : void
      {
         super.init(param1);
         this._type = param1.type;
         this._mode = param1.mode;
         this._link = param1.link;
         if(param1.image)
         {
            if(this._mode == DofusShopEnum.HIGHLIGHT_MODE_CAROUSEL)
            {
               this._image = param1.image["396_221"];
            }
            else if(this._mode == DofusShopEnum.HIGHLIGHT_MODE_IMAGE)
            {
               this._image = param1.image["208_129"];
            }
            
         }
         if(param1.external)
         {
            if(this._type == DofusShopEnum.HIGHLIGHT_TYPE_CATEGORY)
            {
               this._external = new DofusShopCategory(param1.external);
            }
            else if(this._type == DofusShopEnum.HIGHLIGHT_TYPE_ARTICLE)
            {
               this._external = new DofusShopArticle(param1.external);
            }
            
            if(this._mode == DofusShopEnum.HIGHLIGHT_MODE_CAROUSEL && this._external is DofusShopObject)
            {
               if(!_name)
               {
                  _name = DofusShopObject(this._external).name;
               }
               if(!_description)
               {
                  _description = DofusShopObject(this._external).description;
               }
            }
         }
      }
      
      override public function free() : void
      {
         this._type = null;
         this._mode = null;
         this._link = null;
         this._image = null;
         if((this._external) && this._external is DofusShopObject)
         {
            this._external.free();
         }
         this._external = null;
         super.free();
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get mode() : String
      {
         return this._mode;
      }
      
      public function get link() : String
      {
         return this._link;
      }
      
      public function get image() : String
      {
         return this._image;
      }
      
      public function get external() : Object
      {
         return this._external;
      }
   }
}
