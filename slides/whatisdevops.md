[comment]: # (mdslides presentation.md --include media)

[comment]: # (THEME = white)
[comment]: # (CODE_THEME = base16/zenburn)
[comment]: # (The list of themes is at https://revealjs.com/themes/)
[comment]: # (The list of code themes is at https://highlightjs.org/)

[comment]: # (controls: true)
[comment]: # (keyboard: true)
[comment]: # (markdown: { smartypants: true })
[comment]: # (hash: false)
[comment]: # (respondToHashChanges: false)
[comment]: # (width: 1500)
[comment]: # (height: 1000)

DevOps bootcamp - UPES University

# What is DevOps?

![](media/devops1.png)

[comment]: # (!!!)

### Today's agenda

- Waterfall model - the bad old days
- The Agile model
- What is DevOps?
- DevOps phases

[comment]: # (!!!)

## The Waterfall model

<img src="media/Waterfall_model.png" width="45%">

- The traditional software development approach
- Consists of distinct phases
- Linear - each phase must be completed before proceeding to the next

[comment]: # (!!!)

## The Waterfall model


<div style="font-size:20rem;width:100%;text-align:center;">👨‍💼</div>

The product owner

[comment]: # (!!!)

## The Waterfall model


<div style="font-size:20rem;width:100%;text-align:center;">👨‍💻</div>

The developer

[comment]: # (!!!)

## The Waterfall model


<div style="font-size:20rem;width:100%;text-align:center;">👨‍💻 &nbsp &nbsp &nbsp &nbsp 👨‍💼 </div>

⬅️ Product owner specify requirements to the developer

[comment]: # (!!! data-auto-animate)

## The Waterfall model

<div style="font-size:20rem;width:100%;text-align:center;">👨‍💻</div>

The developer design, develop and test the product


[comment]: # (!!! data-auto-animate)

## The Waterfall model

<div style="font-size:10rem;width:100%;text-align:center;">🕒</div>

Six months later...

[comment]: # (!!! data-auto-animate)

## The Waterfall model

<div style="font-size:20rem;width:100%;text-align:center;">👨‍💻 &nbsp &nbsp &nbsp &nbsp 👨‍💼 </div>

The product is delivered ➡️

A one-off event, delivery ceremony 🎉


[comment]: # (!!! data-auto-animate)

## The Waterfall model

<div style="font-size:20rem;width:100%;text-align:center;">👨‍💼 </div>

The product owner is not satisfied with the product 😞

- The product may not be relevant in the market - the requirements miss end-user needs
- The product owner was not involved during the development
- Some features require modifications
- New functionalities are required

⬅️ Specify list changes to the developer

[comment]: # (!!! data-auto-animate)

## The Waterfall model

<div style="font-size:20rem;width:100%;text-align:center;">👨‍💻 &nbsp &nbsp &nbsp &nbsp 👨‍💼 </div>

The developer **re-design**, develop and test again

[comment]: # (!!! data-auto-animate)

## The Waterfall model

<div style="font-size:10rem;width:100%;text-align:center;">🕒</div>

4 months later...

[comment]: # (!!! data-auto-animate)

## The Waterfall model

<div style="font-size:20rem;width:100%;text-align:center;">👨‍💻 &nbsp &nbsp &nbsp &nbsp 👨‍💼 </div>

Another version of the product is delivered ➡️


[comment]: # (!!! data-auto-animate)

## The Waterfall model

#### Organizations soon came to realize

- Product requirements cannot be understood at once
- It's very expensive to make changes only after the product was delivered
- Not like traditional industries (e.g. cars), software development and delivery is an iterative process


[comment]: # (!!! data-auto-animate)

## The Agile model

<img src="media/agile.png" width="85%">

[comment]: # (!!! data-auto-animate)

## The Agile model

[Agile](https://agilemanifesto.org/) model is an iterative and flexible software development approach that emphasizes collaboration, adaptability, and delivering working software in short iterations.

It allows for continuous feedback from end users and stakeholders, enabling quick adjustments and improvements throughout the development process.

[comment]: # (!!! data-auto-animate)

## The Agile model

<div style="font-size:20rem;width:100%;text-align:center;">👨‍💻 &nbsp &nbsp &nbsp &nbsp 👨‍💼 </div>

⬅️ Product owner specify requirements

[comment]: # (!!! data-auto-animate)

## The Agile model

<div style="font-size:20rem;width:100%;text-align:center;">👨‍💻 &nbsp &nbsp &nbsp &nbsp 👨‍💼 </div>

The developer **deploys** his work to production systems ➡️

And immediately gets feedbacks from the product owners and end-users

[comment]: # (!!! data-auto-animate)

## The Agile model

The entire process of software development is broken into small **sprints**, while each sprint (potentially) ends with **deliverables**

<img src="media/agile.png" width="70%">

[comment]: # (!!! data-auto-animate)

## The Agile model

Agile addresses the gap between development to product teams

<img src="media/agile2.png" width="50%">


[comment]: # (!!! data-auto-animate)

## The Operations team

Let's introduce another team player:

<div style="font-size:20rem;width:100%;text-align:center;">👩🏾‍💻</div>

**Operations and infrastructure admin (IT)**

Operations team is responsible to deploy the developer's code to production systems

[comment]: # (!!! data-auto-animate)

## The Operations team challenges

<img src="media/agile3.png" width="80%">

- Small pieces of code are frequently deployed to production systems 
- Operations team release a new product version every week, day, **hour**!
- Challenges in coordinating and integrating deployments

[comment]: # (!!! data-auto-animate)

## DevOps introduced

While Agile addresses the gap between **development** and **product** teams,
it creates new challenges between **development** and **operations** teams

<img src="media/agile4.png" width="80%">

[comment]: # (!!! data-auto-animate)

## DevOps introduced

**DevOps** (development and operations) is a set of methodologies evolved from the Agile development model, aimed to address the gap between development and operations teams.   

<img src="media/agile5.png" width="80%">

[comment]: # (!!! data-auto-animate)

## DevOps Toolchains

<img src="media/devops1.png" width="45%">

A [DevOps toolchain](https://en.wikipedia.org/wiki/DevOps_toolchain) is a set or combination of tools that aid in the delivery, development, and management of software applications throughout the systems development life cycle, as coordinated by an organisation that uses DevOps practices.

[comment]: # (!!! data-auto-animate)

## DevOps Phases - plan

<img src="media/devops1.png" width="45%">

<br>

- Release plan, timing and business case
- Production metrics, objects and feedback
- Requirements

[comment]: # (!!! data-auto-animate)

## DevOps Phases - Create

<img src="media/devops1.png" width="45%">
<br>

- Design of the software and configuration
- Coding

[comment]: # (!!! data-auto-animate)

## DevOps Phases - Verify

<img src="media/devops1.png" width="45%">
<br>

- Regression testing
- Security and vulnerability analysis
- Performance
- Configuration testing


[comment]: # (!!! data-auto-animate)

## DevOps Phases - Packaging

<img src="media/devops1.png" width="45%">
<br>

- Build
- Dependencies management
- Release staging and holding

[comment]: # (!!! data-auto-animate)

## DevOps Phases - Release

<img src="media/devops1.png" width="45%">
<br>

- Deploying and promoting applications
- Fallbacks and recovery
- Scheduled/timed releases

[comment]: # (!!! data-auto-animate)

## DevOps Phases - Configure

<img src="media/devops1.png" width="45%">
<br>

- Infrastructure storage, database and network provisioning and configuring
- Cloud resources provision and configuration

[comment]: # (!!! data-auto-animate)


## DevOps Phases - Monitor

<img src="media/devops1.png" width="45%">
<br>

- Performance of IT infrastructure
- End-user response and experience
- Production metrics and statistics
- Alerting and incident management

[comment]: # (!!! data-auto-animate)


# Thanks!


[comment]: # (!!! data-background-color="aquamarine")


