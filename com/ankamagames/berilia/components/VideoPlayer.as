package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.media.Video;
   import flash.net.NetConnection;
   import flash.net.NetStream;
   import com.ankamagames.jerakine.managers.OptionManager;
   import flash.media.SoundTransform;
   import flash.net.ObjectEncoding;
   import flash.events.NetStatusEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.AsyncErrorEvent;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.components.messages.VideoConnectFailedMessage;
   import com.ankamagames.berilia.components.messages.VideoConnectSuccessMessage;
   import com.ankamagames.berilia.components.messages.VideoBufferChangeMessage;
   
   public class VideoPlayer extends GraphicContainer implements FinalizableUIComponent
   {
      
      public function VideoPlayer() {
         super();
      }
      
      protected static const _log:Logger;
      
      private var _finalized:Boolean;
      
      private var _video:Video;
      
      private var _netConnection:NetConnection;
      
      private var _netStream:NetStream;
      
      private var _flv:String;
      
      private var _fms:String;
      
      private var _client:Object;
      
      private var _autoPlay:Boolean;
      
      private var _mute:Boolean = false;
      
      private var _optionManager:OptionManager;
      
      private var _soundTransform:SoundTransform;
      
      public function finalize() : void {
         NetConnection.defaultObjectEncoding = ObjectEncoding.AMF0;
         graphics.clear();
         graphics.beginFill(0);
         graphics.drawRect(0,0,width,height);
         graphics.endFill();
         this._video = new Video(width,height);
         this._client = new Object();
         this._client.onBWDone = this.onBWDone;
         this._client.onMetaData = this.onMetaData;
         this._netConnection = new NetConnection();
         this._netConnection.addEventListener(NetStatusEvent.NET_STATUS,this.onNetStatus);
         this._netConnection.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
         this._netConnection.addEventListener(AsyncErrorEvent.ASYNC_ERROR,this.onASyncError);
         this._netConnection.client = this._client;
         if(this._autoPlay)
         {
            this.connect();
         }
         this._finalized = true;
         getUi().iAmFinalized(this);
         this._optionManager = OptionManager.getOptionManager("tubul");
         if(this._optionManager)
         {
            this._optionManager.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChange,false,0,true);
            this._soundTransform = new SoundTransform(this._optionManager["volumeAmbientSound"]);
         }
      }
      
      public function connect() : void {
         this._netConnection.connect(this._fms);
      }
      
      public function play() : void {
         var soundTrans:SoundTransform = null;
         if(this._flv)
         {
            this._netStream = new NetStream(this._netConnection);
            this._netStream.client = this._client;
            this._netStream.addEventListener(NetStatusEvent.NET_STATUS,this.onNetStatus);
            this._netStream.addEventListener(AsyncErrorEvent.ASYNC_ERROR,this.onASyncError);
            this._video.attachNetStream(this._netStream);
            this._netStream.soundTransform = this._soundTransform;
            if(this.mute)
            {
               soundTrans = new SoundTransform();
               soundTrans.volume = 0;
               this._netStream.soundTransform = soundTrans;
            }
            this._netStream.play(this._flv);
         }
         else
         {
            _log.error("No Video File to play :(");
         }
      }
      
      public function stop() : void {
         if(this._netStream)
         {
            this._netStream.close();
         }
         this._netConnection.close();
         this._video.clear();
      }
      
      private function onNetStatus(event:NetStatusEvent) : void {
         switch(event.info.code)
         {
            case "NetConnection.Connect.Failed":
               Berilia.getInstance().handler.process(new VideoConnectFailedMessage(this));
               _log.error("Can\'t connect to media server " + this._fms);
               break;
            case "NetStream.Failed":
               Berilia.getInstance().handler.process(new VideoConnectFailedMessage(this));
               _log.error("Can\'t connect to media server " + this._fms);
               break;
            case "NetStream.Play.StreamNotFound":
               Berilia.getInstance().handler.process(new VideoConnectFailedMessage(this));
               _log.error("Video file " + this._flv + " doesn\'t exist");
               break;
            case "Netstream.Play.failed":
               Berilia.getInstance().handler.process(new VideoConnectFailedMessage(this));
               _log.error("Video streaming failed for an unknown reason");
               break;
            case "NetConnection.Connect.Success":
               if(this._autoPlay)
               {
                  this.play();
               }
               Berilia.getInstance().handler.process(new VideoConnectSuccessMessage(this));
               break;
            case "NetStream.Buffer.Full":
               this.resizeVideo();
               addChild(this._video);
               Berilia.getInstance().handler.process(new VideoBufferChangeMessage(this,0));
               break;
            case "NetStream.Buffer.Flush":
               Berilia.getInstance().handler.process(new VideoBufferChangeMessage(this,2));
               break;
            case "NetStream.Buffer.Empty":
               Berilia.getInstance().handler.process(new VideoBufferChangeMessage(this,1));
               break;
         }
      }
      
      private function onSecurityError(event:SecurityErrorEvent) : void {
         Berilia.getInstance().handler.process(new VideoConnectFailedMessage(this));
         _log.error("Security Error: " + event);
      }
      
      private function onASyncError(event:AsyncErrorEvent) : void {
         _log.warn("ASyncError: " + event);
      }
      
      private function onBWDone() : void {
      }
      
      private function onMetaData(info:Object) : void {
      }
      
      private function onPropertyChange(event:PropertyChangeEvent) : void {
         if((this._optionManager["muteAmbientSound"]) || (this._optionManager["tubulIsDesactivated"]))
         {
            this._soundTransform = new SoundTransform(0);
         }
         else
         {
            this._soundTransform = new SoundTransform(this._optionManager["volumeAmbientSound"]);
         }
         if(this._netStream)
         {
            this._netStream.soundTransform = this._soundTransform;
         }
      }
      
      public function set flv(value:String) : void {
         if(!getUi().uiModule.trusted)
         {
            throw new SecurityError();
         }
         else
         {
            split = value.split("file://");
            if(split.length > 1)
            {
               this._flv = split[split.length - 1];
            }
            else
            {
               this._flv = value;
            }
            return;
         }
      }
      
      public function get flv() : String {
         return this._flv;
      }
      
      public function set fms(value:String) : void {
         if(!getUi().uiModule.trusted)
         {
            throw new SecurityError();
         }
         else
         {
            this._fms = value;
            return;
         }
      }
      
      public function get fms() : String {
         return this._fms;
      }
      
      public function get autoPlay() : Boolean {
         return this._autoPlay;
      }
      
      public function set autoPlay(value:Boolean) : void {
         this._autoPlay = value;
      }
      
      public function set finalized(value:Boolean) : void {
         this._finalized = value;
      }
      
      public function get finalized() : Boolean {
         return this._finalized;
      }
      
      public function set mute(mute:Boolean) : void {
         var soundTrans:SoundTransform = null;
         this._mute = mute;
         if(this._netStream)
         {
            soundTrans = new SoundTransform();
            if(mute)
            {
               soundTrans.volume = 0;
            }
            else
            {
               soundTrans.volume = 1;
            }
            this._netStream.soundTransform = soundTrans;
         }
      }
      
      public function get mute() : Boolean {
         return this._mute;
      }
      
      private function resizeVideo() : void {
         var videoRatio:* = NaN;
         var playerRatio:* = NaN;
         if((!(this._video.videoWidth == 0)) && (!(this._video.videoHeight == 0)) && (!(height == 0)))
         {
            videoRatio = this._video.videoWidth / this._video.videoHeight;
            playerRatio = width / height;
            if(videoRatio > playerRatio)
            {
               this.stop();
               if(this._video.parent)
               {
                  removeChild(this._video);
               }
               height = width * 1 / videoRatio;
               y = (1024 - height) / 2;
               this.finalize();
               this.connect();
               this.play();
            }
            else if(videoRatio < playerRatio)
            {
               this.stop();
               if(this._video.parent)
               {
                  removeChild(this._video);
               }
               width = height * videoRatio;
               x = (1280 - width) / 2;
               this.finalize();
               this.connect();
               this.play();
            }
            
         }
      }
   }
}
