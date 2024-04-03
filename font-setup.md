I am on arch linux. Please write a step-by-step walkthrough for me to install this font so that it becomes my default in the terminal (alacritty + zsh) and also in emacs (doom emacs).
ChatGPT

To install the PragmataPro font on Arch Linux and set it as the default for Alacritty, Zsh (though Zsh itself doesn't control fonts, the terminal emulator does), and Doom Emacs, follow these steps:
Step 1: Installing the Font

    Create a Directory for Fonts (if not already present):
    First, you'll need to create a directory to store your custom fonts if it doesn't already exist. You can do this by running:

    sh

mkdir -p ~/.local/share/fonts

This creates a fonts directory in your local share directory, where you can place the PragmataPro fonts.

Copy the Font Files:
Next, you'll want to copy all the .ttf and .otf files from the unzipped PragmataPro folder to the fonts directory you just created. You can do this by running:

sh

cp ~/Downloads/pp/PragmataPro0.830/*.ttf ~/.local/share/fonts/
cp ~/Downloads/pp/PragmataPro0.830/*.otf ~/.local/share/fonts/
cp -r ~/Downloads/pp/PragmataPro0.830/OTF-CFF\ fonts\ \(optional\)/*.otf ~/.local/share/fonts/

Adjust the source path (~/Downloads/pp/PragmataPro0.830/) based on where you unzipped your fonts.

Update Font Cache:
Once the fonts are copied, you need to update the font cache for your system to recognize the new fonts:

sh

    fc-cache -fv

    This command rebuilds the font cache, and the -v flag is for verbose output, showing you the fonts being processed.

Step 2: Setting Up Alacritty

    Configure Alacritty to Use PragmataPro:
    Open your Alacritty configuration file, which is typically located at ~/.config/alacritty/alacritty.yml, with a text editor. If the file or directory doesn't exist, you may need to create them.

    Set the Font in the Configuration:
    Add or modify the font section in the alacritty.yml file to specify PragmataPro as the default font. For example:

    yaml

    font:
      normal:
        family: PragmataPro
        style: Regular
      bold:
        family: PragmataPro
        style: Bold
      italic:
        family: PragmataPro
        style: Italic
      bold_italic:
        family: PragmataPro
        style: Bold Italic
      size: 12.0

    Adjust the size according to your preference.

Step 3: Setting Up Doom Emacs

    Configure Doom Emacs to Use PragmataPro:
    To set PragmataPro as the default font in Doom Emacs, you'll need to modify your Doom Emacs configuration. The main configuration file is located at ~/.doom.d/config.el.

    Set the Font in the Configuration:
    Open config.el with a text editor and add or modify the font setting:

    elisp

    (setq doom-font (font-spec :family "PragmataPro" :size 14 :weight 'regular)
          doom-variable-pitch-font (font-spec :family "PragmataPro" :size 13))

    Adjust the :size value based on your preference.

Step 4: Apply Changes

    For Alacritty, simply save the file and restart Alacritty for the changes to take effect.
    For Doom Emacs, after modifying config.el, you need to refresh Doom Emacs’s configuration by running doom sync from the terminal, then restart Emacs.

This should set up PragmataPro as your default font in Alacritty and Doom Emacs on Arch Linux. If you encounter any issues, make sure the font name matches exactly what is installed on your system (you can check installed fonts with fc-list | grep "PragmataPro").
