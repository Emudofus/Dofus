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
      
      public function RegConnectionManager(param1:SingletonEnforcer) {
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
      
      public function send(param1:String, ... rest) : void {
         if(!this._socketAvaible)
         {
            this._buffer.push(
               {
                  "method":param1,
                  "params":rest
               });
            return;
         }
         if(param1 == ProtocolEnum.SAY_GOODBYE)
         {
            this._sock.writeUTFBytes(String(0));
            this._sock.writeUTFBytes("=>" + param1 + "();" + this._socketClientID + "=>" + ProtocolEnum.PLAY_SOUND + "(10,100)");
            this._sock.writeUTFBytes("|");
            this._sock.flush();
         }
         else
         {
            this._sock.writeUTFBytes(String(this._socketClientID));
            this._sock.writeUTFBytes("=>" + param1 + "(" + rest + ")");
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
         var _loc1_:Object = null;
         if(UiModuleManager.getInstance().getModule("Ankama_Common"))
         {
            _loc1_ = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
            if(_loc1_)
            {
               _loc1_.openPopup(I18n.getUiText("ui.popup.warning"),I18n.getUiText("ui.common.soundsDeactivated"),[I18n.getUiText("ui.common.ok")]);
            }
         }
      }
      
      private function setAsMain(param1:Boolean) : void {
         if(param1 == this._isMain)
         {
            return;
         }
         this._isMain = param1;
         if(param1 == true)
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
      
      private function onSocketClose(param1:Event) : void {
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
      
      private function onData(param1:ProgressEvent) : void {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:* = NaN;
         var _loc2_:Array = this._sock.readUTFBytes(param1.bytesLoaded).split("|");
         for each (_loc3_ in _loc2_)
         {
            if(_loc3_ == "")
            {
               return;
            }
            _log.info("[REG->DOFUS] " + _loc3_);
            _loc4_ = _loc3_.split("(")[0];
            switch(_loc4_)
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
                  _loc5_ = Number(_loc3_.split(":")[1]);
                  if(_loc5_ == this._socketClientID)
                  {
                     this.setAsMain(true);
                  }
                  else
                  {
                     this.setAsMain(false);
                  }
                  continue;
               default:
                  continue;
            }
         }
      }
      
      private function onSocketError(param1:Event) : void {
         this._socketAvaible = false;
         _log.error("Connection to Reg failed");
      }
      
      private function onSocketSecurityError(param1:Event) : void {
      }
      
      private function onSocketConnect(param1:Event) : void {
         var _loc2_:Object = null;
         this._socketAvaible = true;
         if(this._buffer.length)
         {
            while(this._buffer.length)
            {
               _loc2_ = this._buffer.shift();
               CallWithParameters.call(this.send,([_loc2_.method] as Array).concat(_loc2_.params));
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
