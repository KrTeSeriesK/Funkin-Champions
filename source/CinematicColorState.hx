package;

import Controls.Control;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;

class CinematicColorState extends MusicBeatState
{
	var menuBG:FlxSprite;
	
	var lol:Array<String> = ['RED', 'GREEN', 'BLUE'];
	var fuck:Array<Dynamic> = [cinematicolor.red, cinematicolor.green, cinematicolor.blue, FlxColor.RED, FlxColor.LIME, FlxColor.BLUE];
	var grpRGB:FlxTypedGroup<FlxText>;
	var multiplier = 1;
	
	static var curSelected:Int = 0;
	
	public static var cinematicolor:FlxColor = 0xFF000000;
	
	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = lol.length - 1;
		if (curSelected >= lol.length)
			curSelected = 0;

		for (i in 0...lol.length)
		{
			grpRGB.members[i].setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		}
		
		grpRGB.members[curSelected].setFormat(Paths.font("vcr.ttf"), 32, fuck[curSelected + 3], LEFT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
	}
	
    override public function create()
    {
        super.create();
		
		menuBG = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);
				
		grpRGB = new FlxTypedGroup<FlxText>();
		add(grpRGB);

		for (i in 0...lol.length)
		{
			var Value = new FlxText(FlxG.width * 0.8, 7 + (32*i), 200, "", 32);
			Value.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
			Value.ID = i;
			grpRGB.add(Value);
		}
		changeSelection(0);
		
		var dsfgsdgdfgs:FlxText;
		dsfgsdgdfgs = new FlxText(300, 320, 0, "ENTER TO EXIT", 32);
		dsfgsdgdfgs.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		dsfgsdgdfgs.screenCenter(X);
		add(dsfgsdgdfgs);
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
		menuBG.color = cinematicolor;
		grpRGB.members[0].text = 'RED:' + cinematicolor.red;
		grpRGB.members[1].text = 'GREEN:' + cinematicolor.green;
		grpRGB.members[2].text = 'BLUE:' + cinematicolor.blue;
		
		if (controls.UP_P)
			changeSelection(-1);
		if (controls.DOWN_P)
			changeSelection(1);
		
		//why dont oneliners work :(((((((((((((
		if (controls.LEFT)
		{
			switch (curSelected)
			{
				case 0:
					cinematicolor.red--;
				case 1:
					cinematicolor.green--;
				case 2:
					cinematicolor.blue--;
			}
		}
		
		if (controls.RIGHT)
		{	
			switch (curSelected)
			{
				case 0:
					cinematicolor.red++;
				case 1:
					cinematicolor.green++;
				case 2:
					cinematicolor.blue++;
			}
		}
		
		if (controls.ACCEPT)
			FlxG.switchState(new OptionsMenu());
    }
}