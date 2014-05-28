package com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt.TreasureHuntStep;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class TreasureHuntMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TreasureHuntMessage() {
         this.stepList = new Vector.<TreasureHuntStep>();
         super();
      }
      
      public static const protocolId:uint = 6486;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var questType:uint = 0;
      
      public var startMapId:uint = 0;
      
      public var stepList:Vector.<TreasureHuntStep>;
      
      public var checkPointCurrent:uint = 0;
      
      public var checkPointTotal:uint = 0;
      
      public var availableRetryCount:int = 0;
      
      override public function getMessageId() : uint {
         return 6486;
      }
      
      public function initTreasureHuntMessage(questType:uint = 0, startMapId:uint = 0, stepList:Vector.<TreasureHuntStep> = null, checkPointCurrent:uint = 0, checkPointTotal:uint = 0, availableRetryCount:int = 0) : TreasureHuntMessage {
         this.questType = questType;
         this.startMapId = startMapId;
         this.stepList = stepList;
         this.checkPointCurrent = checkPointCurrent;
         this.checkPointTotal = checkPointTotal;
         this.availableRetryCount = availableRetryCount;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.questType = 0;
         this.startMapId = 0;
         this.stepList = new Vector.<TreasureHuntStep>();
         this.checkPointCurrent = 0;
         this.checkPointTotal = 0;
         this.availableRetryCount = 0;
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
         this.serializeAs_TreasureHuntMessage(output);
      }
      
      public function serializeAs_TreasureHuntMessage(output:IDataOutput) : void {
         output.writeByte(this.questType);
         if(this.startMapId < 0)
         {
            throw new Error("Forbidden value (" + this.startMapId + ") on element startMapId.");
         }
         else
         {
            output.writeInt(this.startMapId);
            output.writeShort(this.stepList.length);
            _i3 = 0;
            while(_i3 < this.stepList.length)
            {
               output.writeShort((this.stepList[_i3] as TreasureHuntStep).getTypeId());
               (this.stepList[_i3] as TreasureHuntStep).serialize(output);
               _i3++;
            }
            if(this.checkPointCurrent < 0)
            {
               throw new Error("Forbidden value (" + this.checkPointCurrent + ") on element checkPointCurrent.");
            }
            else
            {
               output.writeInt(this.checkPointCurrent);
               if(this.checkPointTotal < 0)
               {
                  throw new Error("Forbidden value (" + this.checkPointTotal + ") on element checkPointTotal.");
               }
               else
               {
                  output.writeInt(this.checkPointTotal);
                  output.writeInt(this.availableRetryCount);
                  return;
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_TreasureHuntMessage(input);
      }
      
      public function deserializeAs_TreasureHuntMessage(input:IDataInput) : void {
         var _id3:uint = 0;
         var _item3:TreasureHuntStep = null;
         this.questType = input.readByte();
         if(this.questType < 0)
         {
            throw new Error("Forbidden value (" + this.questType + ") on element of TreasureHuntMessage.questType.");
         }
         else
         {
            this.startMapId = input.readInt();
            if(this.startMapId < 0)
            {
               throw new Error("Forbidden value (" + this.startMapId + ") on element of TreasureHuntMessage.startMapId.");
            }
            else
            {
               _stepListLen = input.readUnsignedShort();
               _i3 = 0;
               while(_i3 < _stepListLen)
               {
                  _id3 = input.readUnsignedShort();
                  _item3 = ProtocolTypeManager.getInstance(TreasureHuntStep,_id3);
                  _item3.deserialize(input);
                  this.stepList.push(_item3);
                  _i3++;
               }
               this.checkPointCurrent = input.readInt();
               if(this.checkPointCurrent < 0)
               {
                  throw new Error("Forbidden value (" + this.checkPointCurrent + ") on element of TreasureHuntMessage.checkPointCurrent.");
               }
               else
               {
                  this.checkPointTotal = input.readInt();
                  if(this.checkPointTotal < 0)
                  {
                     throw new Error("Forbidden value (" + this.checkPointTotal + ") on element of TreasureHuntMessage.checkPointTotal.");
                  }
                  else
                  {
                     this.availableRetryCount = input.readInt();
                     return;
                  }
               }
            }
         }
      }
   }
}
