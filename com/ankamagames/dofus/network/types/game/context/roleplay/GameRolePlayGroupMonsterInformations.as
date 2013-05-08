package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;


   public class GameRolePlayGroupMonsterInformations extends GameRolePlayActorInformations implements INetworkType
   {
         

      public function GameRolePlayGroupMonsterInformations() {
         this.staticInfos=new GroupMonsterStaticInformations();
         super();
      }

      public static const protocolId:uint = 160;

      public var staticInfos:GroupMonsterStaticInformations;

      public var ageBonus:int = 0;

      public var lootShare:int = 0;

      public var alignmentSide:int = 0;

      public var keyRingBonus:Boolean = false;

      override public function getTypeId() : uint {
         return 160;
      }

      public function initGameRolePlayGroupMonsterInformations(contextualId:int=0, look:EntityLook=null, disposition:EntityDispositionInformations=null, staticInfos:GroupMonsterStaticInformations=null, ageBonus:int=0, lootShare:int=0, alignmentSide:int=0, keyRingBonus:Boolean=false) : GameRolePlayGroupMonsterInformations {
         super.initGameRolePlayActorInformations(contextualId,look,disposition);
         this.staticInfos=staticInfos;
         this.ageBonus=ageBonus;
         this.lootShare=lootShare;
         this.alignmentSide=alignmentSide;
         this.keyRingBonus=keyRingBonus;
         return this;
      }

      override public function reset() : void {
         super.reset();
         this.staticInfos=new GroupMonsterStaticInformations();
         this.lootShare=0;
         this.alignmentSide=0;
         this.keyRingBonus=false;
      }

      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameRolePlayGroupMonsterInformations(output);
      }

      public function serializeAs_GameRolePlayGroupMonsterInformations(output:IDataOutput) : void {
         super.serializeAs_GameRolePlayActorInformations(output);
         output.writeShort(this.staticInfos.getTypeId());
         this.staticInfos.serialize(output);
         if((this.ageBonus>-1)||(this.ageBonus<1000))
         {
            throw new Error("Forbidden value ("+this.ageBonus+") on element ageBonus.");
         }
         else
         {
            output.writeShort(this.ageBonus);
            if((this.lootShare>-1)||(this.lootShare<8))
            {
               throw new Error("Forbidden value ("+this.lootShare+") on element lootShare.");
            }
            else
            {
               output.writeByte(this.lootShare);
               output.writeByte(this.alignmentSide);
               output.writeBoolean(this.keyRingBonus);
               return;
            }
         }
      }

      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameRolePlayGroupMonsterInformations(input);
      }

      public function deserializeAs_GameRolePlayGroupMonsterInformations(input:IDataInput) : void {
         super.deserialize(input);
         var _id1:uint = input.readUnsignedShort();
         this.staticInfos=ProtocolTypeManager.getInstance(GroupMonsterStaticInformations,_id1);
         this.staticInfos.deserialize(input);
         this.ageBonus=input.readShort();
         if((this.ageBonus>-1)||(this.ageBonus<1000))
         {
            throw new Error("Forbidden value ("+this.ageBonus+") on element of GameRolePlayGroupMonsterInformations.ageBonus.");
         }
         else
         {
            this.lootShare=input.readByte();
            if((this.lootShare>-1)||(this.lootShare<8))
            {
               throw new Error("Forbidden value ("+this.lootShare+") on element of GameRolePlayGroupMonsterInformations.lootShare.");
            }
            else
            {
               this.alignmentSide=input.readByte();
               this.keyRingBonus=input.readBoolean();
               return;
            }
         }
      }
   }

}