package com.ankamagames.dofus.logic.game.common.types
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class DofusShopObject extends Object implements IDataCenter
   {
      
      public function DofusShopObject(param1:Object)
      {
         super();
         if(param1)
         {
            this.init(param1);
         }
      }
      
      protected var _id:int;
      
      protected var _name:String;
      
      protected var _description:String;
      
      public function init(param1:Object) : void
      {
         this._id = param1.id;
         this._name = param1.name;
         this._description = param1.description;
         if(this._description)
         {
            this._description = this._description.replace(new RegExp("\\s*<li>","ig"),"<li>");
            this._description = this._description.replace(new RegExp("(\\s*<.l>\\s*)|(\\s*<\\/.l>\\s*)","ig"),"\n");
         }
      }
      
      public function free() : void
      {
         this._id = 0;
         this._name = null;
         this._description = null;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get description() : String
      {
         return this._description;
      }
   }
}
