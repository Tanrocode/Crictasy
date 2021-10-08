import requests
import json
import discord
import random

client = discord.Client()

@client.event
async def on_ready():
    print(f'{client.user} has connected to Discord!')

@client.command()
async def matches(ctx):

    author = ctx.message.author
    channel = ctx.channel

    keys = []

    def msg_check(m):
        return m.author == author and m.channel == channel

    def get_data(date):

        url = f"https://cricket-live-data.p.rapidapi.com/results-by-date/{date}"

        headers = {
            'x-rapidapi-host': "cricket-live-data.p.rapidapi.com",
            'x-rapidapi-key': f"{random.choice(keys)}"
        }

        response = requests.request("GET", url, headers=headers)
        json_response = json.dumps(response)

    embed1 = discord.Embed(
        description = "Say the date of the match. FORMAT: YEAR-MONTH-DAY",
        colour = discord.Colour.red()
        )

    await ctx.send(embed = main2)    
    user_input = await client.wait_for('message', check=msg_check())

    print(get_data(user_input))

    


