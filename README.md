# n8n on MyKinsta

This repository contains the configuration to deploy n8n (workflow automation tool) on MyKinsta using GitHub integration.

## Prerequisites

- MyKinsta account
- GitHub account with this repository

## MyKinsta Deployment Steps

### 1. Connect GitHub Repository to MyKinsta

1. Log in to your [MyKinsta dashboard](https://my.kinsta.com/)
2. Navigate to **Applications** in the sidebar
3. Click **Add application**
4. Select **GitHub** as your Git provider
5. Authorize MyKinsta to access your GitHub repositories (if not already done)
6. Select this repository: `SSF-solutions1/N8N-kinsta`
7. Choose the branch: `claude/n8n-mykinsta-github-setup-015iybgKa8Tg6Nq4PtPGRaJ9` (or your preferred branch)

### 2. Configure Application Settings

**Build Environment:**
- **Build method:** Dockerfile
- **Dockerfile path:** `Dockerfile` (default)
- **Context path:** `.` (root directory)

**Deployment Settings:**
- **Port:** `8080`
- **Region:** Choose your preferred region (e.g., US Central, Europe West)
- **Instance size:** Start with the smallest and scale up as needed

### 3. Set Environment Variables

In the MyKinsta application settings, add the following environment variables:

**Required:**
- `N8N_PORT` = `8080`
- `WEBHOOK_URL` = `https://your-app-name.kinsta.app` (replace with your actual Kinsta app URL)
- `N8N_PROTOCOL` = `https`

**Recommended:**
- `N8N_BASIC_AUTH_ACTIVE` = `true`
- `N8N_BASIC_AUTH_USER` = `your-username`
- `N8N_BASIC_AUTH_PASSWORD` = `your-secure-password`
- `GENERIC_TIMEZONE` = `America/New_York` (or your timezone)
- `TZ` = `America/New_York` (or your timezone)

**Optional (for production):**
- `N8N_ENCRYPTION_KEY` = `your-encryption-key` (generate a secure random string)
- `N8N_USER_MANAGEMENT_JWT_SECRET` = `your-jwt-secret` (generate a secure random string)

### 4. Deploy

1. Click **Create application** or **Deploy now**
2. MyKinsta will automatically:
   - Clone your repository
   - Build the Docker image
   - Deploy the container
   - Assign a public URL (e.g., `https://your-app-name.kinsta.app`)

### 5. Access n8n

Once deployed, access your n8n instance at the provided Kinsta URL. If you enabled basic auth, you'll be prompted for credentials.

## Important Notes

### Database

This setup uses SQLite stored in `/tmp/n8n/database.sqlite`. **Important:** Data in `/tmp` may not persist across container restarts on MyKinsta.

**For production use, consider:**
- Using MyKinsta's persistent storage if available
- Migrating to PostgreSQL or MySQL (requires updating environment variables)
- Setting up regular backups

### Webhook URL

After deployment, update the `WEBHOOK_URL` environment variable in MyKinsta with your actual application URL:
```
WEBHOOK_URL=https://your-actual-app-name.kinsta.app
```

Then redeploy the application for changes to take effect.

### Automatic Deployments

MyKinsta can automatically deploy when you push to your connected branch:
1. Go to your application settings in MyKinsta
2. Enable "Automatic deployment on push"
3. Any commits pushed to the connected branch will trigger a new deployment

## Upgrading n8n

To upgrade to the latest n8n version:
1. The Dockerfile uses `n8nio/n8n:latest`
2. Trigger a rebuild in MyKinsta or push a change to trigger auto-deployment
3. MyKinsta will pull the latest image and redeploy

## Troubleshooting

### Application won't start
- Check logs in MyKinsta dashboard
- Verify port 8080 is correctly configured
- Ensure environment variables are set correctly

### Can't access workflows after restart
- SQLite database in `/tmp` may not persist
- Consider migrating to a persistent database solution

### Webhooks not working
- Verify `WEBHOOK_URL` matches your actual Kinsta app URL
- Check that `N8N_PROTOCOL` is set to `https`

## Support

- n8n Documentation: https://docs.n8n.io/
- MyKinsta Support: https://kinsta.com/help/
- n8n Community: https://community.n8n.io/

## Security Recommendations

1. **Enable Basic Auth** or set up user management
2. Use **strong passwords** and **encryption keys**
3. Keep **n8n updated** to the latest version
4. Review n8n's security best practices: https://docs.n8n.io/hosting/security/
