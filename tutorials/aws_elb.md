# Load Balancing

Before starting the tutorial, make sure your VPC has at least 2 different **public subnets**. Create ones of needed.

## Create Application Load Balancer

### Configure a target group

Configuring a target group allows you to register targets such as EC2 instances\.

1. Open the Amazon EC2 console at [https://console\.aws\.amazon\.com/ec2/](https://console.aws.amazon.com/ec2/)\.

2. In the left navigation pane, under **Load Balancing**, choose **Target Groups**\.

3. Choose **Create target group**\.

4. In the **Basic configuration** section, set the following parameters:

    1. For **Choose a target type**, select **Instance** to specify targets by instance ID

    2. For **Target group name**, enter a name for the target group\.

    3. Leave the **Port** and **Protocol** as HTTP 8080.

    4. For VPC, select your virtual private cloud \(VPC\)

    5. For **Protocol version**, select **HTTP1**.

5. In the **Health checks** section, modify the default settings as needed to perform a health checks to the Flask webserver at endpoint `/status` ([simple_flask_webserver](../simple_flask_webserver/app.py))\.

6. Choose **Next**\.
7. In the **Register targets** page, add one or more targets by selecting one or more instances, enter one or more ports, and then choose **Include as pending below**\.
8. Choose **Create target group**\.

### Configure a load balancer and a listener

To create an Application Load Balancer, you must first provide basic configuration information for your load balancer, such as a name, scheme, and IP address type\.
Then, you provide information about your network, and one or more listeners\.
A listener is a process that checks for connection requests\. It is configured with a protocol and a port for connections from clients to the load balancer\.

1. In the navigation pane, under **Load Balancing**, choose **Load Balancers**\.

2. Choose **Create Load Balancer**\.

3. Under **Application Load Balancer**, choose **Create**\.

4. **Basic configuration**

    1. For **Load balancer name**, enter a name for your load balancer\.

    2. For **Scheme**, choose **Internet\-facing**.
       An internet\-facing load balancer routes requests from clients to targets over the internet\.

    3. For **IP address type**, choose **IPv4**.

5. **Network mapping**

    1. For **VPC**, select the VPC that you used for your EC2 instances\. As you selected **Internet\-facing** for **Scheme**, only VPCs with an internet gateway are available for selection\.

    1. For **Mappings**, select two or more Availability Zones and corresponding subnets\. Enabling multiple Availability Zones increases the fault tolerance of your applications\.

6. For **Security groups**, select an existing security group, or create a new one\.

   The security group for your load balancer must allow it to communicate with registered targets on both the listener port and the health check port\. The console can create a security group for your load balancer on your behalf with rules that allow this communication\. You can also create a security group and select it instead\. See [recommended rules](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-update-security-groups.html#security-group-recommended-rules)

7. For Listeners and routing, the default listener accepts HTTP traffic on port 80. Choose different ones port according to your app. For Default action, choose the target group that you created.
9. Review your configuration, and choose **Create load balancer**\. A few default attributes are applied to your load balancer during creation\. You can view and edit them after creating the load balancer\. For more information, see [Load balancer attributes](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/application-load-balancers.html#load-balancer-attributes)\.


### Test the load balancer under load

Deploy 2 EC2 instances within your VPC, in each instance, run our so-called simple flask webserver. 

We will use the `locust` Python package to perform a load test.
[Locust](https://docs.locust.io/en/stable/quickstart.html) is an easy to use, scriptable and scalable performance testing tool.

Install it by:

```bash
pip install locust
```

Take a look on the file under Launch the locust test UI by:

```bash 
cd http_load_test
locust
```

Open http://localhost:8089. 
Provide the host name of your server and try it out!

During the load test, turn off one of your instance, observe the behavior.


# Self-check questions

[Enter the interactive self-check page](https://alonitac.github.io/DevOpsBootcampUPES/multichoice-questions/aws_elb.html)

# Exercises

## :pencil2: Application Load Balancer with TLS termination

### Create TLS certificate

We would like our load balancers to listen on HTTPS protocol for clients connection. In order to achieve that, we need to create and sign a digital certificate.

In order to create your own SSL certificate, perform the following in your local machine (`openssl` required):
1. Generate private key as private.pem
   ```
   openssl genrsa -out private.pem 2048
   ```
2. Generate public key as public.pem
   ```
   openssl rsa -in private.pem -outform PEM -pubout -out public.pem
   ```
3. Create a CSR (Certificate Signing Request) as certificate.csr
   ```
   openssl req -new -key private.pem -out certificate.csr
   ```
4. Create a Self-signed certificate as certificate.crt
   ```
   openssl x509 -req -days 365 -in certificate.csr -signkey private.pem -out certificate.crt
   ```

IAM securely encrypts your private keys and stores the encrypted version in IAM SSL certificate storage. You cannot manage your certificates from the IAM Console.

5. To upload a server certificate to IAM (make sure your local aws cli is configured with the proper credentials)
   ```shell
   aws iam upload-server-certificate --server-certificate-name <your-cert-name> --certificate-body file://certificate.crt --private-key file://private.pem
   ```

### Add an HTTPS listener to your load balancer

1. On the navigation pane, under **Load Balancing**, choose **Load Balancers**\.

2. Select a load balancer, and choose **Listeners**, **Add listener**\.

3. For **Protocol : port**, choose **HTTPS** and keep the default port or enter a different port\.

4. For **Default actions**, choose **Add action**, **Forward to** and choose a target group\.

5. For **Security policy**, we recommend that you keep the default security policy\.

6. For **Default SSL certificate**, choose **From IAM** and choose the certificate that you uploaded\.

7. Choose **Save**\.

8. Test your load balancer over HTTPS.

## :pencil2: Working with sticky sessions

Sticky session is a load balancing technique commonly used in web applications that require maintaining user session state.
It ensures that all requests from a particular user are routed **to the same instance** that initially handled their request, allowing the server to maintain session data and provide a consistent user experience.
This is particularly useful for applications that rely on session-specific information or personalized settings.

1. On the navigation pane, under **Load Balancing**, choose **Target Groups**\.

2. Choose the name of the target group to open its details page\.

3. On the **Group details** tab, in the **Attributes** section, choose **Edit**\.

4. On the **Edit attributes** page, do the following:

    1. Select **Stickiness**\.

    2. For **Stickiness type**, select **Load balancer generated cookie**\.

    3. For **Stickiness duration**, specify a value between 1 second and 7 days\.

    4. Choose **Save changes**\.

5. Make sure stickiness is applied by requesting the URL multiple times and validating that you always communicate with the same instance.  


