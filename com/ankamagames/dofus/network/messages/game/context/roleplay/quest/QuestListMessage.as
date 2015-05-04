package com.ankamagames.dofus.network.messages.game.context.roleplay.quest
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.quest.QuestActiveInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class QuestListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function QuestListMessage()
      {
         this.finishedQuestsIds = new Vector.<uint>();
         this.finishedQuestsCounts = new Vector.<uint>();
         this.activeQuests = new Vector.<QuestActiveInformations>();
         super();
      }
      
      public static const protocolId:uint = 5626;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var finishedQuestsIds:Vector.<uint>;
      
      public var finishedQuestsCounts:Vector.<uint>;
      
      public var activeQuests:Vector.<QuestActiveInformations>;
      
      override public function getMessageId() : uint
      {
         return 5626;
      }
      
      public function initQuestListMessage(param1:Vector.<uint> = null, param2:Vector.<uint> = null, param3:Vector.<QuestActiveInformations> = null) : QuestListMessage
      {
         this.finishedQuestsIds = param1;
         this.finishedQuestsCounts = param2;
         this.activeQuests = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.finishedQuestsIds = new Vector.<uint>();
         this.finishedQuestsCounts = new Vector.<uint>();
         this.activeQuests = new Vector.<QuestActiveInformations>();
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_QuestListMessage(param1);
      }
      
      public function serializeAs_QuestListMessage(param1:ICustomDataOutput) : void
      {
         param1.writeShort(this.finishedQuestsIds.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.finishedQuestsIds.length)
         {
            if(this.finishedQuestsIds[_loc2_] < 0)
            {
               throw new Error("Forbidden value (" + this.finishedQuestsIds[_loc2_] + ") on element 1 (starting at 1) of finishedQuestsIds.");
            }
            else
            {
               param1.writeVarShort(this.finishedQuestsIds[_loc2_]);
               _loc2_++;
               continue;
            }
         }
         param1.writeShort(this.finishedQuestsCounts.length);
         var _loc3_:uint = 0;
         while(_loc3_ < this.finishedQuestsCounts.length)
         {
            if(this.finishedQuestsCounts[_loc3_] < 0)
            {
               throw new Error("Forbidden value (" + this.finishedQuestsCounts[_loc3_] + ") on element 2 (starting at 1) of finishedQuestsCounts.");
            }
            else
            {
               param1.writeVarShort(this.finishedQuestsCounts[_loc3_]);
               _loc3_++;
               continue;
            }
         }
         param1.writeShort(this.activeQuests.length);
         var _loc4_:uint = 0;
         while(_loc4_ < this.activeQuests.length)
         {
            param1.writeShort((this.activeQuests[_loc4_] as QuestActiveInformations).getTypeId());
            (this.activeQuests[_loc4_] as QuestActiveInformations).serialize(param1);
            _loc4_++;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_QuestListMessage(param1);
      }
      
      public function deserializeAs_QuestListMessage(param1:ICustomDataInput) : void
      {
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:QuestActiveInformations = null;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc8_ = param1.readVarUhShort();
            if(_loc8_ < 0)
            {
               throw new Error("Forbidden value (" + _loc8_ + ") on elements of finishedQuestsIds.");
            }
            else
            {
               this.finishedQuestsIds.push(_loc8_);
               _loc3_++;
               continue;
            }
         }
         var _loc4_:uint = param1.readUnsignedShort();
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_)
         {
            _loc9_ = param1.readVarUhShort();
            if(_loc9_ < 0)
            {
               throw new Error("Forbidden value (" + _loc9_ + ") on elements of finishedQuestsCounts.");
            }
            else
            {
               this.finishedQuestsCounts.push(_loc9_);
               _loc5_++;
               continue;
            }
         }
         var _loc6_:uint = param1.readUnsignedShort();
         var _loc7_:uint = 0;
         while(_loc7_ < _loc6_)
         {
            _loc10_ = param1.readUnsignedShort();
            _loc11_ = ProtocolTypeManager.getInstance(QuestActiveInformations,_loc10_);
            _loc11_.deserialize(param1);
            this.activeQuests.push(_loc11_);
            _loc7_++;
         }
      }
   }
}
