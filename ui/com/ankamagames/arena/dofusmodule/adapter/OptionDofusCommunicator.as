package com.ankamagames.arena.dofusmodule.adapter
{
   import flash.events.EventDispatcher;
   import flash.events.Event;
   import d2api.SystemApi;
   import d2api.SoundApi;
   import d2api.ConfigApi;
   
   public class OptionDofusCommunicator extends EventDispatcher implements IOptionCommunicator
   {
      
      public function OptionDofusCommunicator(sysApi:SystemApi, soundApi:SoundApi, configApi:ConfigApi) {
         super();
         this._sysApi = sysApi;
         this._soundApi = soundApi;
         this._configApi = configApi;
      }
      
      public static const EVT_MUTE_ARENA:String = "com.ankamagames.arena.dofusmodule.adapter.OptionDofusCommunicator.EVT_MUTE_ARENA";
      
      public static const EVT_UNMUTE_ARENA:String = "com.ankamagames.arena.dofusmodule.adapter.OptionDofusCommunicator.EVT_UNMUTE_ARENA";
      
      public function destroy() : void {
         this._sysApi = null;
         this._soundApi = null;
         this._configApi = null;
      }
      
      public function getHostCurrentLanguage() : String {
         return this._sysApi.getCurrentLanguage();
      }
      
      public function isSoundActivated() : Boolean {
         return this._soundApi.soundsAreActivated();
      }
      
      public function setMusicVolume(volume:Number) : void {
         this._configApi.setConfigProperty("tubul","volumeMusic",volume);
      }
      
      public function setAmbianceVolume(volume:Number) : void {
         this._configApi.setConfigProperty("tubul","volumeAmbientSound",volume);
      }
      
      public function setSoundVolume(volume:Number) : void {
         this._configApi.setConfigProperty("tubul","volumeSound",volume);
      }
      
      public function getMusicVolume() : Number {
         return this._configApi.getConfigProperty("tubul","volumeMusic");
      }
      
      public function getAmbianceVolume() : Number {
         return this._configApi.getConfigProperty("tubul","volumeAmbientSound");
      }
      
      public function getSoundVolume() : Number {
         return this._configApi.getConfigProperty("tubul","volumeSound");
      }
      
      public function maximise() : void {
         this._musicVolume = this.getMusicVolume();
         this._ambientVolume = this.getAmbianceVolume();
         this._soundVolume = this.getSoundVolume();
         this.setMusicVolume(0);
         this.setAmbianceVolume(0);
         dispatchEvent(new Event(EVT_UNMUTE_ARENA));
      }
      
      public function minimise() : void {
         this.setMusicVolume(this._musicVolume);
         this.setAmbianceVolume(this._ambientVolume);
         dispatchEvent(new Event(EVT_MUTE_ARENA));
      }
      
      private var _sysApi:SystemApi;
      
      private var _soundApi:SoundApi;
      
      private var _configApi:ConfigApi;
      
      private var _soundVolume:Number;
      
      private var _ambientVolume:Number;
      
      private var _musicVolume:Number;
   }
}
