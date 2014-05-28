package com.ankamagames.dofus.datacenter.servers
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.data.I18n;
   
   public class Server extends Object implements IDataCenter
   {
      
      public function Server() {
         super();
      }
      
      protected static const _log:Logger;
      
      public static const MODULE:String = "Servers";
      
      public static function getServerById(id:int) : Server {
         return GameData.getObject(MODULE,id) as Server;
      }
      
      public static function getServers() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:int;
      
      public var nameId:uint;
      
      public var commentId:uint;
      
      public var openingDate:Number;
      
      public var language:String;
      
      public var populationId:int;
      
      public var gameTypeId:uint;
      
      public var communityId:int;
      
      public var restrictedToLanguages:Vector.<String>;
      
      private var _name:String;
      
      private var _comment:String;
      
      private var _gameType:ServerGameType;
      
      private var _community:ServerCommunity;
      
      private var _population:ServerPopulation;
      
      public function get name() : String {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
      
      public function get comment() : String {
         if(!this._comment)
         {
            this._comment = I18n.getText(this.commentId);
         }
         return this._comment;
      }
      
      public function get gameType() : ServerGameType {
         if((!this._gameType) || (!(this._gameType.id == this.gameTypeId)))
         {
            this._gameType = ServerGameType.getServerGameTypeById(this.gameTypeId);
         }
         return this._gameType;
      }
      
      public function get community() : ServerCommunity {
         if((!this._community) || (!(this._community.id == this.communityId)))
         {
            this._community = ServerCommunity.getServerCommunityById(this.communityId);
         }
         return this._community;
      }
      
      public function get population() : ServerPopulation {
         if(!this._population)
         {
            this._population = ServerPopulation.getServerPopulationById(this.populationId);
         }
         return this._population;
      }
   }
}
