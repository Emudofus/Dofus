package com.ankamagames.dofus.network.messages.game.startup
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class StartupActionsObjetAttributionMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function StartupActionsObjetAttributionMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 1303;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var actionId:uint = 0;
      
      public var characterId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 1303;
      }
      
      public function initStartupActionsObjetAttributionMessage(param1:uint = 0, param2:uint = 0) : StartupActionsObjetAttributionMessage
      {
         this.actionId = param1;
         this.characterId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.actionId = 0;
         this.characterId = 0;
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
         this.serializeAs_StartupActionsObjetAttributionMessage(param1);
      }
      
      public function serializeAs_StartupActionsObjetAttributionMessage(param1:ICustomDataOutput) : void
      {
         if(this.actionId < 0)
         {
            throw new Error("Forbidden value (" + this.actionId + ") on element actionId.");
         }
         else
         {
            param1.writeInt(this.actionId);
            if(this.characterId < 0)
            {
               throw new Error("Forbidden value (" + this.characterId + ") on element characterId.");
            }
            else
            {
               param1.writeInt(this.characterId);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_StartupActionsObjetAttributionMessage(param1);
      }
      
      public function deserializeAs_StartupActionsObjetAttributionMessage(param1:ICustomDataInput) : void
      {
         this.actionId = param1.readInt();
         if(this.actionId < 0)
         {
            throw new Error("Forbidden value (" + this.actionId + ") on element of StartupActionsObjetAttributionMessage.actionId.");
         }
         else
         {
            this.characterId = param1.readInt();
            if(this.characterId < 0)
            {
               throw new Error("Forbidden value (" + this.characterId + ") on element of StartupActionsObjetAttributionMessage.characterId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
