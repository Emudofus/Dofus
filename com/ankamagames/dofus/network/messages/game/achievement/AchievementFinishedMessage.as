package com.ankamagames.dofus.network.messages.game.achievement
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AchievementFinishedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AchievementFinishedMessage() {
         super();
      }
      
      public static const protocolId:uint = 6208;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var id:uint = 0;
      
      public var finishedlevel:uint = 0;
      
      override public function getMessageId() : uint {
         return 6208;
      }
      
      public function initAchievementFinishedMessage(param1:uint=0, param2:uint=0) : AchievementFinishedMessage {
         this.id = param1;
         this.finishedlevel = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.id = 0;
         this.finishedlevel = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_AchievementFinishedMessage(param1);
      }
      
      public function serializeAs_AchievementFinishedMessage(param1:IDataOutput) : void {
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         else
         {
            param1.writeShort(this.id);
            if(this.finishedlevel < 0 || this.finishedlevel > 200)
            {
               throw new Error("Forbidden value (" + this.finishedlevel + ") on element finishedlevel.");
            }
            else
            {
               param1.writeShort(this.finishedlevel);
               return;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_AchievementFinishedMessage(param1);
      }
      
      public function deserializeAs_AchievementFinishedMessage(param1:IDataInput) : void {
         this.id = param1.readShort();
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of AchievementFinishedMessage.id.");
         }
         else
         {
            this.finishedlevel = param1.readShort();
            if(this.finishedlevel < 0 || this.finishedlevel > 200)
            {
               throw new Error("Forbidden value (" + this.finishedlevel + ") on element of AchievementFinishedMessage.finishedlevel.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
