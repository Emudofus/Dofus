package com.ankamagames.dofus.misc
{
    import com.ankamagames.dofus.network.types.game.look.SubEntity;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import com.ankamagames.berilia.managers.SecureCenter;
    import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;

    public class EntityLookAdapter 
    {


        public static function fromNetwork(n:EntityLook):TiphonEntityLook
        {
            var skin:uint;
            var se:SubEntity;
            var index:uint;
            var color:uint;
            var o:TiphonEntityLook = new TiphonEntityLook();
            o.lock();
            o.setBone(n.bonesId);
            for each (skin in n.skins)
            {
                o.addSkin(skin);
            };
            if ((((n.bonesId == 1)) || ((n.bonesId == 2))))
            {
                o.defaultSkin = 1965;
            };
            var i:uint;
            while (i < n.indexedColors.length)
            {
                index = ((n.indexedColors[i] >> 24) & 0xFF);
                color = (n.indexedColors[i] & 0xFFFFFF);
                o.setColor(index, color);
                i++;
            };
            if (n.scales.length == 1)
            {
                o.setScales((n.scales[0] / 100), (n.scales[0] / 100));
            }
            else
            {
                if (n.scales.length == 2)
                {
                    o.setScales((n.scales[0] / 100), (n.scales[1] / 100));
                };
            };
            for each (se in n.subentities)
            {
                o.addSubEntity(se.bindingPointCategory, se.bindingPointIndex, EntityLookAdapter.fromNetwork(se.subEntityLook));
            };
            o.unlock(true);
            return (o);
        }

        public static function toNetwork(o:TiphonEntityLook):EntityLook
        {
            var colorIndexStr:String;
            var subEntities:Array;
            var catStr:String;
            var colorIndex:uint;
            var color:uint;
            var indexedColor:uint;
            var cat:uint;
            var indStr:String;
            var ind:uint;
            var se:SubEntity;
            var n:EntityLook = new EntityLook();
            n.bonesId = o.getBone();
            n.skins = o.getSkins(false, false);
            var colors:Array = o.getColors(true);
            for (colorIndexStr in colors)
            {
                colorIndex = parseInt(colorIndexStr);
                color = colors[colorIndexStr];
                indexedColor = (((colorIndex & 0xFF) << 24) | (color & 0xFFFFFF));
                n.indexedColors.push(indexedColor);
            };
            n.scales.push(uint((o.getScaleX() * 100)));
            n.scales.push(uint((o.getScaleY() * 100)));
            subEntities = o.getSubEntities(true);
            for (catStr in subEntities)
            {
                cat = parseInt(catStr);
                for (indStr in subEntities[catStr])
                {
                    ind = parseInt(indStr);
                    se = new SubEntity();
                    se.initSubEntity(cat, ind, EntityLookAdapter.toNetwork(subEntities[catStr][indStr]));
                    n.subentities.push(se);
                };
            };
            return (n);
        }

        public static function tiphonizeLook(rawLook:*):TiphonEntityLook
        {
            var entityLook:TiphonEntityLook;
            rawLook = SecureCenter.unsecure(rawLook);
            if ((rawLook is TiphonEntityLook))
            {
                entityLook = (rawLook as TiphonEntityLook);
            };
            if ((rawLook is EntityLook))
            {
                entityLook = fromNetwork(rawLook);
            };
            if ((rawLook is String))
            {
                entityLook = TiphonEntityLook.fromString(rawLook);
            };
            return (entityLook);
        }

        public static function getRiderLook(rawLook:*):TiphonEntityLook
        {
            rawLook = SecureCenter.unsecure(rawLook);
            var oldEntityLook:TiphonEntityLook = tiphonizeLook(rawLook);
            var entityLook:TiphonEntityLook = oldEntityLook.clone();
            var ridderLook:TiphonEntityLook = entityLook.getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0);
            if (ridderLook)
            {
                if (ridderLook.getBone() == 2)
                {
                    ridderLook.setBone(1);
                };
                entityLook = ridderLook;
            };
            return (entityLook);
        }


    }
}//package com.ankamagames.dofus.misc

