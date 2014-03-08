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
      
      public function initAchievementFinishedMessage(id:uint=0, finishedlevel:uint=0) : AchievementFinishedMessage {
         this.id = id;
         this.finishedlevel = finishedlevel;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.id = 0;
         this.finishedlevel = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_AchievementFinishedMessage(output);
      }
      
      public function serializeAs_AchievementFinishedMessage(output:IDataOutput) : void {
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         else
         {
            output.writeShort(this.id);
            if((this.finishedlevel < 0) || (this.finishedlevel > 200))
            {
               throw new Error("Forbidden value (" + this.finishedlevel + ") on element finishedlevel.");
            }
            else
            {
               output.writeShort(this.finishedlevel);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AchievementFinishedMessage(input);
      }
      
      public function deserializeAs_AchievementFinishedMessage(input:IDataInput) : void {
         this.id = input.readShort();
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of AchievementFinishedMessage.id.");
         }
         else
         {
            this.finishedlevel = input.readShort();
            if((this.finishedlevel < 0) || (this.finishedlevel > 200))
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
