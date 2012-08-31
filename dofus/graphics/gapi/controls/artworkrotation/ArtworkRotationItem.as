// Action script...

// [Initial MovieClip Action of sprite 1021]
#initclip 242
class dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem extends ank.gapi.core.UIBasicComponent
{
    var _nSex, __get__sex, _ldrArtwork, _oLastTransform, __set__sex;
    function ArtworkRotationItem()
    {
        super();
    } // End of the function
    function set sex(nSex)
    {
        _nSex = Number(nSex);
        //return (this.sex());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.CLASS_NAME);
    } // End of the function
    function loadArtwork(nClassID)
    {
        var _loc2 = dofus.Constants.GUILDS_BIG_PATH + nClassID + _nSex + ".swf";
        _ldrArtwork.__set__contentPath(_loc2);
    } // End of the function
    function colorize(bNoTransform, bAnimation)
    {
        if (bAnimation == undefined)
        {
            bAnimation = false;
        } // end if
        var nLen = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.RED.length;
        var cTmp = new Color(_ldrArtwork);
        var oTmp = new Object();
        var nI = bNoTransform ? (nLen - 1) : (0);
        if (!bAnimation)
        {
            oTmp.ra = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.PERCENT[nI];
            oTmp.rb = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.RED[nI];
            oTmp.ga = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.PERCENT[nI];
            oTmp.gb = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.GREEN[nI];
            oTmp.ba = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.PERCENT[nI];
            oTmp.bb = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.BLUE[nI];
            cTmp.setTransform(oTmp);
        }
        else
        {
            var nInc = bNoTransform ? (-1) : (1);
            function onEnterFrame()
            {
                oTmp.ra = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.PERCENT[nI];
                oTmp.rb = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.RED[nI];
                oTmp.ga = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.PERCENT[nI];
                oTmp.gb = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.GREEN[nI];
                oTmp.ba = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.PERCENT[nI];
                oTmp.bb = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.BLUE[nI];
                cTmp.setTransform(oTmp);
                nI = nI + nInc;
                if (nI >= nLen || nI < 0)
                {
                    _oLastTransform = oTmp;
                    delete this.onEnterFrame;
                } // end if
            } // End of the function
        } // end else if
    } // End of the function
    static var CLASS_NAME = "ArtworkRotationItem";
    static var RED = [0, 45, 89, 134, 178];
    static var GREEN = [0, 35, 70, 106, 141];
    static var BLUE = [0, 25, 50, 75, 100];
    static var PERCENT = [100, 75, 50, 25, 0];
} // End of Class
#endinitclip
