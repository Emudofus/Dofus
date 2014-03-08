package com.ankamagames.dofus.kernel.updaterv2.messages.impl
{
   import com.ankamagames.dofus.kernel.updaterv2.messages.IUpdaterInputMessage;
   
   public class FinishedMessage extends Object implements IUpdaterInputMessage
   {
      
      public function FinishedMessage() {
         super();
      }
      
      private var _error:ErrorMessage;
      
      private var _needRestart:Boolean;
      
      private var _needUpdate:Boolean;
      
      private var _newVersion:String;
      
      private var _previousVersion:String;
      
      private var _project:String;
      
      public function deserialize(param1:Object) : void {
         this._needRestart = param1["needRestart"];
         this._needUpdate = param1["needUpdate"];
         this._newVersion = param1["newVersion"];
         this._previousVersion = param1["previousVersion"];
         this._project = param1["project"];
      }
      
      public function get error() : ErrorMessage {
         return this._error;
      }
      
      public function get needRestart() : Boolean {
         return this._needRestart;
      }
      
      public function get needUpdate() : Boolean {
         return this._needUpdate;
      }
      
      public function get newVersion() : String {
         return this._newVersion;
      }
      
      public function get previousVersion() : String {
         return this._previousVersion;
      }
      
      public function get project() : String {
         return this._project;
      }
      
      public function toString() : String {
         return "[FinishedMessage error=" + this._error + ", needRestart=" + this._needRestart + ", needUpdate=" + this._needUpdate + ", newVersion=" + this._newVersion + ", previousVersion=" + this._previousVersion + ", project=" + this._project + "]";
      }
   }
}
