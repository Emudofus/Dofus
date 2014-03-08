package com.ankamagames.jerakine.script
{
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.interfaces.IScriptsPlayer;
   
   public class ScriptsManager extends Object
   {
      
      public function ScriptsManager() {
         this._players = new Dictionary();
         this._apis = new Dictionary();
         super();
      }
      
      private static var _self:ScriptsManager;
      
      public static function getInstance() : ScriptsManager {
         if(!_self)
         {
            _self = new ScriptsManager();
         }
         return _self;
      }
      
      public static const LUA_PLAYER:String = "LUA_PLAYER";
      
      private var _players:Dictionary;
      
      private var _apis:Dictionary;
      
      public function addPlayer(param1:String, param2:IScriptsPlayer) : void {
         this._players[param1] = param2;
      }
      
      public function getPlayer(param1:String) : IScriptsPlayer {
         return this._players[param1];
      }
      
      public function addPlayerApi(param1:IScriptsPlayer, param2:String, param3:*) : void {
         if(!this._apis[param1])
         {
            this._apis[param1] = new Dictionary();
         }
         this._apis[param1][param2] = param3;
         param1.addApi(param2,param3);
      }
      
      public function getPlayerApi(param1:IScriptsPlayer, param2:String) : * {
         var _loc3_:* = undefined;
         if(this._apis[param1])
         {
            _loc3_ = this._apis[param1][param2];
         }
         return _loc3_;
      }
      
      public function playScript(param1:String, param2:String) : void {
         this._players[param1].playScript(param2);
      }
      
      public function playFile(param1:String, param2:String) : void {
         this._players[param1].playFile(param2);
      }
   }
}
