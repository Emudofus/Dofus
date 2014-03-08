package com.ankamagames.dofus.network.types.game.actions.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class AbstractFightDispellableEffect extends Object implements INetworkType
   {
      
      public function AbstractFightDispellableEffect() {
         super();
      }
      
      public static const protocolId:uint = 206;
      
      public var uid:uint = 0;
      
      public var targetId:int = 0;
      
      public var turnDuration:int = 0;
      
      public var dispelable:uint = 1;
      
      public var spellId:uint = 0;
      
      public var parentBoostUid:uint = 0;
      
      public function getTypeId() : uint {
         return 206;
      }
      
      public function initAbstractFightDispellableEffect(uid:uint=0, targetId:int=0, turnDuration:int=0, dispelable:uint=1, spellId:uint=0, parentBoostUid:uint=0) : AbstractFightDispellableEffect {
         this.uid = uid;
         this.targetId = targetId;
         this.turnDuration = turnDuration;
         this.dispelable = dispelable;
         this.spellId = spellId;
         this.parentBoostUid = parentBoostUid;
         return this;
      }
      
      public function reset() : void {
         this.uid = 0;
         this.targetId = 0;
         this.turnDuration = 0;
         this.dispelable = 1;
         this.spellId = 0;
         this.parentBoostUid = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_AbstractFightDispellableEffect(output);
      }
      
      public function serializeAs_AbstractFightDispellableEffect(output:IDataOutput) : void {
         if(this.uid < 0)
         {
            throw new Error("Forbidden value (" + this.uid + ") on element uid.");
         }
         else
         {
            output.writeInt(this.uid);
            output.writeInt(this.targetId);
            output.writeShort(this.turnDuration);
            output.writeByte(this.dispelable);
            if(this.spellId < 0)
            {
               throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
            }
            else
            {
               output.writeShort(this.spellId);
               if(this.parentBoostUid < 0)
               {
                  throw new Error("Forbidden value (" + this.parentBoostUid + ") on element parentBoostUid.");
               }
               else
               {
                  output.writeInt(this.parentBoostUid);
                  return;
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AbstractFightDispellableEffect(input);
      }
      
      public function deserializeAs_AbstractFightDispellableEffect(input:IDataInput) : void {
         this.uid = input.readInt();
         if(this.uid < 0)
         {
            throw new Error("Forbidden value (" + this.uid + ") on element of AbstractFightDispellableEffect.uid.");
         }
         else
         {
            this.targetId = input.readInt();
            this.turnDuration = input.readShort();
            this.dispelable = input.readByte();
            if(this.dispelable < 0)
            {
               throw new Error("Forbidden value (" + this.dispelable + ") on element of AbstractFightDispellableEffect.dispelable.");
            }
            else
            {
               this.spellId = input.readShort();
               if(this.spellId < 0)
               {
                  throw new Error("Forbidden value (" + this.spellId + ") on element of AbstractFightDispellableEffect.spellId.");
               }
               else
               {
                  this.parentBoostUid = input.readInt();
                  if(this.parentBoostUid < 0)
                  {
                     throw new Error("Forbidden value (" + this.parentBoostUid + ") on element of AbstractFightDispellableEffect.parentBoostUid.");
                  }
                  else
                  {
                     return;
                  }
               }
            }
         }
      }
   }
}
