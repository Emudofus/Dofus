package com.ankamagames.arena.dofusmodule.adapter
{
   import flash.events.IEventDispatcher;
   
   public interface IOptionCommunicator extends IEventDispatcher
   {
      
      function destroy() : void;
      
      function getHostCurrentLanguage() : String;
      
      function isSoundActivated() : Boolean;
      
      function setMusicVolume(param1:Number) : void;
      
      function setAmbianceVolume(param1:Number) : void;
      
      function setSoundVolume(param1:Number) : void;
      
      function getMusicVolume() : Number;
      
      function getAmbianceVolume() : Number;
      
      function getSoundVolume() : Number;
   }
}
