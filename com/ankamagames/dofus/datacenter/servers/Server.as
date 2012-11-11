package com.ankamagames.dofus.datacenter.servers
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class Server extends Object implements IDataCenter
    {
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
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Server));
        private static const MODULE:String = "Servers";

        public function Server()
        {
            return;
        }// end function

        public function get name() : String
        {
            if (!this._name)
            {
                this._name = I18n.getText(this.nameId);
            }
            return this._name;
        }// end function

        public function get comment() : String
        {
            if (!this._comment)
            {
                this._comment = I18n.getText(this.commentId);
            }
            return this._comment;
        }// end function

        public function get gameType() : ServerGameType
        {
            if (!this._gameType)
            {
                this._gameType = ServerGameType.getServerGameTypeById(this.gameTypeId);
            }
            return this._gameType;
        }// end function

        public function get community() : ServerCommunity
        {
            if (!this._community)
            {
                this._community = ServerCommunity.getServerCommunityById(this.communityId);
            }
            return this._community;
        }// end function

        public function get population() : ServerPopulation
        {
            if (!this._population)
            {
                this._population = ServerPopulation.getServerPopulationById(this.populationId);
            }
            return this._population;
        }// end function

        public static function getServerById(param1:int) : Server
        {
            return GameData.getObject(MODULE, param1) as Server;
        }// end function

        public static function getServers() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
