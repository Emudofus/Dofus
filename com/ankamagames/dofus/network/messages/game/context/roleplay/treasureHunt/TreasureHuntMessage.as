package com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt.TreasureHuntStep;
   import com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt.TreasureHuntFlag;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class TreasureHuntMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TreasureHuntMessage() {
         this.knownStepsList = new Vector.<TreasureHuntStep>();
         this.flags = new Vector.<TreasureHuntFlag>();
         super();
      }
      
      public static const protocolId:uint = 6486;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var questType:uint = 0;
      
      public var startMapId:int = 0;
      
      public var knownStepsList:Vector.<TreasureHuntStep>;
      
      public var totalStepCount:uint = 0;
      
      public var checkPointCurrent:uint = 0;
      
      public var checkPointTotal:uint = 0;
      
      public var availableRetryCount:int = 0;
      
      public var flags:Vector.<TreasureHuntFlag>;
      
      override public function getMessageId() : uint {
         return 6486;
      }
      
      public function initTreasureHuntMessage(questType:uint = 0, startMapId:int = 0, knownStepsList:Vector.<TreasureHuntStep> = null, totalStepCount:uint = 0, checkPointCurrent:uint = 0, checkPointTotal:uint = 0, availableRetryCount:int = 0, flags:Vector.<TreasureHuntFlag> = null) : TreasureHuntMessage {
         this.questType = questType;
         this.startMapId = startMapId;
         this.knownStepsList = knownStepsList;
         this.totalStepCount = totalStepCount;
         this.checkPointCurrent = checkPointCurrent;
         this.checkPointTotal = checkPointTotal;
         this.availableRetryCount = availableRetryCount;
         this.flags = flags;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.questType = 0;
         this.startMapId = 0;
         this.knownStepsList = new Vector.<TreasureHuntStep>();
         this.totalStepCount = 0;
         this.checkPointCurrent = 0;
         this.checkPointTotal = 0;
         this.availableRetryCount = 0;
         this.flags = new Vector.<TreasureHuntFlag>();
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
         output.writeInt(this.startMapId);
         output.writeShort(this.knownStepsList.length);
         var _i3:uint = 0;
         while(_i3 < this.knownStepsList.length)
         {
            output.writeShort((this.knownStepsList[_i3] as TreasureHuntStep).getTypeId());
            (this.knownStepsList[_i3] as TreasureHuntStep).serialize(output);
            _i3++;
         }
         if(this.totalStepCount < 0)
         {
            throw new Error("Forbidden value (" + this.totalStepCount + ") on element totalStepCount.");
         }
         else
         {
            output.writeByte(this.totalStepCount);
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
                  output.writeShort(this.flags.length);
                  _i8 = 0;
                  while(_i8 < this.flags.length)
                  {
                     (this.flags[_i8] as TreasureHuntFlag).serializeAs_TreasureHuntFlag(output);
                     _i8++;
                  }
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
         var _item8:TreasureHuntFlag = null;
         this.questType = input.readByte();
         if(this.questType < 0)
         {
            throw new Error("Forbidden value (" + this.questType + ") on element of TreasureHuntMessage.questType.");
         }
         else
         {
            this.startMapId = input.readInt();
            _knownStepsListLen = input.readUnsignedShort();
            _i3 = 0;
            while(_i3 < _knownStepsListLen)
            {
               _id3 = input.readUnsignedShort();
               _item3 = ProtocolTypeManager.getInstance(TreasureHuntStep,_id3);
               _item3.deserialize(input);
               this.knownStepsList.push(_item3);
               _i3++;
            }
            this.totalStepCount = input.readByte();
            if(this.totalStepCount < 0)
            {
               throw new Error("Forbidden value (" + this.totalStepCount + ") on element of TreasureHuntMessage.totalStepCount.");
            }
            else
            {
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
                     _flagsLen = input.readUnsignedShort();
                     _i8 = 0;
                     while(_i8 < _flagsLen)
                     {
                        _item8 = new TreasureHuntFlag();
                        _item8.deserialize(input);
                        this.flags.push(_item8);
                        _i8++;
                     }
                     return;
                  }
               }
            }
         }
      }
   }
}
