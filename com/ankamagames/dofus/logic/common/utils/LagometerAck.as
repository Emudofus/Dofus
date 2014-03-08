package com.ankamagames.dofus.logic.common.utils
{
   import __AS3__.vec.Vector;
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
      
      override public function ping(param1:INetworkMessage=null) : void {
         var _loc2_:MiscFrame = null;
         if(!this._active)
         {
            _loc2_ = Kernel.getWorker().getFrame(MiscFrame) as MiscFrame;
            if((_loc2_) && (_loc2_.isOptionalFeatureActive(this._optionId)))
            {
               this._active = true;
            }
         }
         if(!this._active)
         {
            super.ping(param1);
            return;
         }
         if(!this._msgTimeStack.length)
         {
            _timer.delay = SHOW_LAG_DELAY;
            _timer.start();
         }
         this._msgTimeStack.push(getTimer());
      }
      
      override public function pong(param1:INetworkMessage=null) : void {
         var _loc2_:uint = 0;
         if(!this._active)
         {
            super.pong(param1);
            return;
         }
         if(param1 is BasicAckMessage)
         {
            _loc2_ = getTimer() - this._msgTimeStack.shift();
            if(_loc2_ > SHOW_LAG_DELAY)
            {
               _log.debug(_loc2_ + " ms de latence (basé sur ACK)");
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
