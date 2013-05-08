package com.ankamagames.dofus.datacenter.appearance
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.data.I18n;


   public class Title extends Object implements IDataCenter
   {
         

      public function Title() {
         super();
      }

      public static const MODULE:String = "Titles";

      public static function getTitleById(id:int) : Title {
         return GameData.getObject(MODULE,id) as Title;
      }

      public static function getAllTitle() : Array {
         return GameData.getObjects(MODULE);
      }

      public var id:int;

      public var nameMaleId:uint;

      public var nameFemaleId:uint;

      public var visible:Boolean;

      public var categoryId:int;

      private var _nameM:String;

      private var _nameF:String;

      public function get name() : String {
         if(PlayedCharacterManager.getInstance().infos.sex==0)
         {
            if(!this._nameM)
            {
               this._nameM=I18n.getText(this.nameMaleId);
            }
            return this._nameM;
         }
         if(!this._nameF)
         {
            this._nameF=I18n.getText(this.nameFemaleId);
         }
         return this._nameF;
      }

      public function get nameMale() : String {
         if(!this._nameM)
         {
            this._nameM=I18n.getText(this.nameMaleId);
         }
         return this._nameM;
      }

      public function get nameFemale() : String {
         if(!this._nameF)
         {
            this._nameF=I18n.getText(this.nameFemaleId);
         }
         return this._nameF;
      }
   }

}