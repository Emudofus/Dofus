package com.ankamagames.dofus.logic.common.utils
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.logic.common.frames.MiscFrame;
   import com.ankamagames.dofus.kernel.Kernel;
   import flash.utils.getTimer;
   import com.ankamagames.dofus.network.messages.game.basic.BasicAckMessage;
   import com.ankamagames.dofus.datacenter.misc.OptionalFeature;
   
   public class LagometerAck extends Lagometer
   {
      
      public function LagometerAck() {
         this._msgTimeStack = new Vector.<uint>();
         super();
         this._optionId = OptionalFeature.getOptionalFeatureByKeyword("net.ack").id;
      }
      
      private var _msgTimeStack:Vector.<uint>;
      
      private var _active:Boolean = false;
      
      private var _optionId:uint;
      
      override public function stop() : void {
         if(_timer.running)
         {
            _timer.stop();
         }
         this._msgTimeStack.length = 0;
      }
      
      override public function ping(msg:INetworkMessage = null) : void {
         var f:MiscFrame = null;
         if(!this._active)
         {
            f = Kernel.getWorker().getFrame(MiscFrame) as MiscFrame;
            if((f) && (f.isOptionalFeatureActive(this._optionId)))
            {
               this._active = true;
            }
         }
         if(!this._active)
         {
            super.ping(msg);
            return;
         }
         if(!this._msgTimeStack.length)
         {
            _timer.delay = SHOW_LAG_DELAY;
            _timer.start();
         }
         this._msgTimeStack.push(getTimer());
      }
      
      override public function pong(msg:INetworkMessage = null) : void {
         var latency:uint = 0;
         if(!this._active)
         {
            super.pong(msg);
            return;
         }
         if(msg is BasicAckMessage)
         {
            latency = getTimer() - this._msgTimeStack.shift();
            if(latency > SHOW_LAG_DELAY)
            {
               _log.debug(latency + " ms de latence (basé sur ACK)");
               startLag();
               if(_timer.running)
               {
                  _timer.stop();
               }
            }
            else
            {
               stopLag();
               if(this._msgTimeStack.length)
               {
                  _timer.delay = Math.max(0,SHOW_LAG_DELAY - (getTimer() - this._msgTimeStack[0]));
                  _timer.start();
               }
               else
               {
                  _timer.stop();
               }
            }
         }
      }
   }
}
