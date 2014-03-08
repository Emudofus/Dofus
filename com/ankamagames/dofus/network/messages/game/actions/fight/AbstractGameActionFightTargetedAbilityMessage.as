package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AbstractGameActionFightTargetedAbilityMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public function AbstractGameActionFightTargetedAbilityMessage() {
         super();
      }
      
      public static const protocolId:uint = 6118;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var targetId:int = 0;
      
      public var destinationCellId:int = 0;
      
      public var critical:uint = 1;
      
      public var silentCast:Boolean = false;
      
      override public function getMessageId() : uint {
         return 6118;
      }
      
      public function initAbstractGameActionFightTargetedAbilityMessage(param1:uint=0, param2:int=0, param3:int=0, param4:int=0, param5:uint=1, param6:Boolean=false) : AbstractGameActionFightTargetedAbilityMessage {
         super.initAbstractGameActionMessage(param1,param2);
         this.targetId = param3;
         this.destinationCellId = param4;
         this.critical = param5;
         this.silentCast = param6;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.targetId = 0;
         this.destinationCellId = 0;
         this.critical = 1;
         this.silentCast = false;
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
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_AbstractGameActionFightTargetedAbilityMessage(param1);
      }
      
      public function serializeAs_AbstractGameActionFightTargetedAbilityMessage(param1:IDataOutput) : void {
         super.serializeAs_AbstractGameActionMessage(param1);
         param1.writeInt(this.targetId);
         if(this.destinationCellId < -1 || this.destinationCellId > 559)
         {
            throw new Error("Forbidden value (" + this.destinationCellId + ") on element destinationCellId.");
         }
         else
         {
            param1.writeShort(this.destinationCellId);
            param1.writeByte(this.critical);
            param1.writeBoolean(this.silentCast);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_AbstractGameActionFightTargetedAbilityMessage(param1);
      }
      
      public function deserializeAs_AbstractGameActionFightTargetedAbilityMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.targetId = param1.readInt();
         this.destinationCellId = param1.readShort();
         if(this.destinationCellId < -1 || this.destinationCellId > 559)
         {
            throw new Error("Forbidden value (" + this.destinationCellId + ") on element of AbstractGameActionFightTargetedAbilityMessage.destinationCellId.");
         }
         else
         {
            this.critical = param1.readByte();
            if(this.critical < 0)
            {
               throw new Error("Forbidden value (" + this.critical + ") on element of AbstractGameActionFightTargetedAbilityMessage.critical.");
            }
            else
            {
               this.silentCast = param1.readBoolean();
               return;
            }
         }
      }
   }
}
