package com.ankamagames.dofus.kernel.sound.manager
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.net.Socket;
   import com.ankamagames.jerakine.protocolAudio.ProtocolEnum;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import com.ankamagames.jerakine.sound.FlashSoundSender;
   import flash.events.ProgressEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import com.ankamagames.jerakine.utils.system.CommandLineArguments;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.kernel.sound.SoundManager;
   import com.ankamagames.jerakine.utils.misc.CallWithParameters;
   
   public class RegConnectionManager extends Object
   {
      
      public function RegConnectionManager(pSingletonEnforcer:SingletonEnforcer) {
         super();
         if(_self)
         {
            throw new Error("RegConnectionManager is a Singleton");
         }
         else
         {
            this.init();
            return;
         }
      }
      
      private static var _log:Logger = Log.getLogger(getQualifiedClassName(RegConnectionManager));
      
      private static var _self:RegConnectionManager;
      
      public static function getInstance() : RegConnectionManager {
         if(_self == null)
         {
            _self = new RegConnectionManager(new SingletonEnforcer());
         }
         return _self;
      }
      
      private var _sock:Socket;
      
      private var _socketClientID:uint;
      
      private var _socketAvaible:Boolean;
      
      private var _buffer:Array;
      
      private var _isMain:Boolean = true;
      
      public function get socketClientID() : uint {
         return this._socketClientID;
      }
      
      public function get socketAvailable() : Boolean {
         return this._socketAvaible;
      }
      
      public function get isMain() : Boolean {
         return this._isMain;
      }
      
      public function send(pMethodName:String, ... params) : void {
         if(!this._socketAvaible)
         {
            this._buffer.push(
               {
                  "method":pMethodName,
                  "params":params
               });
            return;
         }
         if(pMethodName == ProtocolEnum.SAY_GOODBYE)
         {
            this._sock.writeUTFBytes(String(0));
            this._sock.writeUTFBytes("=>" + pMethodName + "();" + this._socketClientID + "=>" + ProtocolEnum.PLAY_SOUND + "(10,100)");
            this._sock.writeUTFBytes("|");
            this._sock.flush();
         }
         else
         {
            this._sock.writeUTFBytes(String(this._socketClientID));
            this._sock.writeUTFBytes("=>" + pMethodName + "(" + params + ")");
            this._sock.writeUTFBytes("|");
            this._sock.flush();
         }
      }
      
      private function init() : void {
         this._socketClientID = uint.MAX_VALUE * Math.random();
         if(AirScanner.isStreamingVersion())
         {
            _log.debug("init flash sound sender");
            this._sock = new FlashSoundSender(Dofus.getInstance().REG_LOCAL_CONNECTION_ID);
         }
         else
         {
            _log.debug("init socket");
            this._sock = new Socket();
         }
         this._sock.addEventListener(ProgressEvent.SOCKET_DATA,this.onData);
         this._sock.addEventListener(Event.CONNECT,this.onSocketConnect);
         this._sock.addEventListener(Event.CLOSE,this.onSocketClose);
         this._sock.addEventListener(IOErrorEvent.IO_ERROR,this.onSocketError);
         this._sock.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSocketSecurityError);
         if(CommandLineArguments.getInstance().hasArgument("reg-client-port"))
         {
            this._sock.connect("localhost",int(CommandLineArguments.getInstance().getArgument("reg-client-port")));
         }
         else
         {
            this._sock.connect("localhost",8081);
         }
         this._buffer = [];
      }
      
      private function showInformationPopup() : void {
         var commonMod:Object = null;
         if(UiModuleManager.getInstance().getModule("Ankama_Common"))
         {
            commonMod = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
            if(commonMod)
            {
               commonMod.openPopup(I18n.getUiText("ui.popup.warning"),I18n.getUiText("ui.common.soundsDeactivated"),[I18n.getUiText("ui.common.ok")]);
            }
         }
      }
      
      private function setAsMain(pMain:Boolean) : void {
         if(pMain == this._isMain)
         {
            return;
         }
         this._isMain = pMain;
         if(pMain == true)
         {
            _log.warn("[" + this._socketClientID + "] Je passe en main");
            if(SoundManager.getInstance().manager is RegSoundManager)
            {
               (SoundManager.getInstance().manager as RegSoundManager).playMainClientSounds();
            }
         }
         else
         {
            _log.warn("[" + this._socketClientID + "] Je ne suis plus main");
            if(SoundManager.getInstance().manager is RegSoundManager)
            {
               (SoundManager.getInstance().manager as RegSoundManager).stopMainClientSounds();
            }
         }
      }
      
      private function onSocketClose(e:Event) : void {
         this._socketAvaible = false;
         _log.error("The socket has been closed");
         try
         {
            this.showInformationPopup();
         }
         catch(e:Error)
         {
         }
      }
      
      private function onData(pEvent:ProgressEvent) : void {
         var cmd:String = null;
         var functionName:String = null;
         var clientId:* = NaN;
         var cmds:Array = this._sock.readUTFBytes(pEvent.bytesLoaded).split("|");
         for each (cmd in cmds)
         {
            if(cmd == "")
            {
               return;
            }
            _log.info("[REG->DOFUS] " + cmd);
            functionName = cmd.split("(")[0];
            switch(functionName)
            {
               case ProtocolEnum.REG_SHUT_DOWN:
                  this._socketAvaible = false;
                  _log.error("The socket connection with REG has been lost");
                  this.showInformationPopup();
                  continue;
               case ProtocolEnum.REG_IS_UP:
                  this._socketAvaible = true;
                  _log.info("The socket connection with REG has been established");
                  continue;
               case ProtocolEnum.PING:
                  _log.info("receive ping request from reg, send pong");
                  this.send(ProtocolEnum.PONG);
                  continue;
               case ProtocolEnum.MAIN_CLIENT_IS:
                  clientId = Number(cmd.split(":")[1]);
                  if(clientId == this._socketClientID)
                  {
                     this.setAsMain(true);
                  }
                  else
                  {
                     this.setAsMain(false);
                  }
                  continue;
            }
         }
      }
      
      private function onSocketError(e:Event) : void {
         this._socketAvaible = false;
         _log.error("Connection to Reg failed");
      }
      
      private function onSocketSecurityError(e:Event) : void {
      }
      
      private function onSocketConnect(e:Event) : void {
         var cmd:Object = null;
         this._socketAvaible = true;
         if(this._buffer.length)
         {
            while(this._buffer.length)
            {
               cmd = this._buffer.shift();
               CallWithParameters.call(this.send,([cmd.method] as Array).concat(cmd.params));
            }
         }
      }
   }
}
class SingletonEnforcer extends Object
{
   
   function SingletonEnforcer() {
      super();
   }
}
