# computercraft-mc-player
A computercraft music playing program in lua for playing music in-game!

![Screenshot](https://github.com/marc0sj0estar/computercraft-mc-player/assets/108777250/b5b9bdcb-83b9-4244-afa4-4a7df73eedcc)

## How to use
1. Download all the files in the repository
2. Place all the files in the computer directory (C:\Users\User\AppData\Roaming\.minecraft\saves\WorldName\computercraft\computer\ComputerId).
3. Place all your music in a music disc.
> [!NOTE]
> The music files must be in a .dfpwm format. Read the guide below if you don't know how to convert them.
4. Turn on the computer that you placed the files into and insert the compact disk on a connected disk drive.
5. To switch between pages press the button at the bottom of the monitor.
6. When playing a song use the bottom arrows to access the previous and next song.

It will automatically go to the next song when the current song is done playing.

## Customization
To change the appearance of the interface, open the startup.lua file and change the values of the variables at the top of the file under Customization.
The available colors compatible with computercraft are:
| Color | Appearance |
| --- | :---: |
|colors.white | ![#f0f0f0](https://placehold.co/15x15/f0f0f0/f0f0f0.png)|
|colors.orange | ![#F2B233](https://placehold.co/15x15/F2B233/F2B233.png)|
|colors.magenta | ![#E57FD8](https://placehold.co/15x15/E57FD8/E57FD8.png)|
|colors.lightBlue | ![#99B2F2](https://placehold.co/15x15/99B2F2/99B2F2.png)|
|colors.yellow | ![#DEDE6C](https://placehold.co/15x15/DEDE6C/DEDE6C.png)|
|colors.lime | ![#7FCC19](https://placehold.co/15x15/7FCC19/7FCC19.png)|
|colors.pink | ![#F2B2CC](https://placehold.co/15x15/F2B2CC/F2B2CC.png)|
|colors.gray | ![#4C4C4C](https://placehold.co/15x15/4C4C4C/4C4C4C.png)|
|colors.lightGray | ![#999999](https://placehold.co/15x15/999999/999999.png)|
|colors.cyan | ![#4C99B2](https://placehold.co/15x15/4C99B2/4C99B2.png)|
|colors.purple | ![#B266E5](https://placehold.co/15x15/B266E5/B266E5.png)|
|colors.blue | ![#3366CC](https://placehold.co/15x15/3366CC/3366CC.png)|
|colors.brown | ![#7F664C](https://placehold.co/15x15/7F664C/7F664C.png)|
|colors.green | ![#57A64E](https://placehold.co/15x15/57A64E/57A64E.png)|
|colors.red | ![#CC4C4C](https://placehold.co/15x15/CC4C4C/CC4C4C.png)|
|colors.black | ![#111111](https://placehold.co/15x15/111111/111111.png)|

![image](https://github.com/marc0sj0estar/computercraft-mc-player/assets/108777250/7c77aa27-eaa6-4ac2-9a68-ef8c915871a0)

## How to turn music into .dfpwm
To turn normal music files like mp3 into .dfpwm you can use:
  - https://remote.craftos-pc.cc/music/
  - https://music.madefor.cc/
## How to put music into a compact disk
After crafting a compact disk, insert it into a disk drive connected to an available computer.
For the disk folder to appear in your minecraft directory you first need to add a temporary file that you can delete afterwards.
Insert the compact disk in the disk drive and run the following commands in the computer terminal:
```
cd /disk
edit temporary
```
Then press **Ctrl -> Save** and **Ctr -> Exit**. 
Afterwards run the command:
```
rm /disk/temporary
```
If done correctly a new folder should appear in (C:\Users\User\AppData\Roaming\.minecraft\saves\WorldName\computercraft\disk).
Finally, put all your music into the new folder and insert the compact disk into a computer running the program.

## Additional notes
The program adapts to the monitor size, so you can use this program from large music systems to tiny jukeboxes.

![image](https://github.com/marc0sj0estar/computercraft-mc-player/assets/108777250/b9a4931e-5ea2-45d5-9081-7f31d3dd960a)

You can use the networking cables and modems to place the speakers in different places and cover a large area.

The reference photos use the fantastic [Create: ComputerCraft (CC: Tweaked)](https://www.curseforge.com/minecraft/texture-packs/create-computercraft) resource pack by EndRage

